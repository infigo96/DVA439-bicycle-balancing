%One script to rule them all
clear;
close all;
warning('off', 'all')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cartpole state limiters and actions constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
startState = [0 0 0 0];
Q1 = 0;
Q2 = 0;
Q3 = 0;
Q4 = 0;

force = 10;
actions = [-force, force]; % Either force backward or forward
allowedPoleAngle = pi/10;
deathPoleAngle = pi/5;
allowedCartPos = 1.2;
deathCartPos = 2.4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up the pendulum plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
panel = figure;
panel.Color = [1 1 1];

hold on
% Axis for the pendulum animation
f = plot(0,0,'b','LineWidth',6); % Pendulum stick
axPend = f.Parent;
axPend.XTick = []; % No axis stuff to see
axPend.YTick = [];
axPend.Visible = 'off';
axPend.Clipping = 'off';
axis equal
axis([-1.2679 1.2679 -1 1]); %bottom line
line([-2.4 2.4],[0 0],'color', 'red')
g  = plot(0.001,0,'.k','MarkerSize',30); % Pendulum axis point
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup initial experiences and init net
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TrSet = {};
Input = [];
goal = 100;
nrOfActions = 0;

% Init Net
% Choose a Training Function and size
trainFcn = 'trainrp';
hiddenLayerSize = [10 8 6];

% Create a Fitting Network
net = fitnet(hiddenLayerSize,trainFcn);
net.trainParam.showWindow = false;
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
net.divideMode = 'none';  % Divide up every sample
net.performFcn = 'mse';
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
net.layers{4}.transferFcn = 'logsig';


i = 1;
while i <= 20
    currentState = [0.4*rand-0.2, 0.2*rand-0.1, (2*pi*rand-pi)/30,(2*pi*rand-pi)/30];
    
    while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle)
        
        action = actions(ceil(2*rand));
        nextState = SimulatePendel(action, currentState(1), currentState(2), currentState(3), currentState(4));
        Input(i,1:5) = [currentState action];
        Target(i,1) = rand;
        currentState = nextState;
        i = i + 1; 
    end
end

[net,tr] = adapt(net,Input',Target');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q-fitted training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Used to indicate savepoints of network
bestActionNr = 0;
% Goal of the training
maxRange = 2000;
StateActionPair = [];
sPrim = [];
Qvalues = [];
Qnew = [];
actionInfo = [];
Episodes = [];
gamma = 0.9;
alpha = 0.1;
for i = 1:2000
    currentState = [0.4*rand-0.2, 0.2*rand-0.1, (2*pi*rand-pi)/30,(2*pi*rand-pi)/30];
    actionNr = 0;
    while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle)
        actionNr = actionNr + 1;
        Qvalues = [Qvalues;[abs(net([currentState actions(1)]')) abs(net([currentState actions(2)]'))]];
        if ((rand < 0.05+0.6^i+0.7/(i+1)) || (Qvalues(1) == Qvalues(2)))
            acindex = ceil(2*rand);
            actionInfo = [actionInfo; 0 1*(acindex == 1) 1*(acindex == 2)]; 
        else
            [temp, acindex] = min(Qvalues(end,:));
            actionInfo = [actionInfo; 1 1*(acindex == 1) 1*(acindex == 2)];
        end
        StateActionPair = [StateActionPair; currentState acindex]; %Remember 2 transform index to action
        nextState = SimulatePendel(actions(acindex), currentState(1), currentState(2), currentState(3), currentState(4));
        sPrim = [sPrim; nextState];
        currentState = nextState;
        Episodes(i) = actionNr;
        %Set display of internal loop on
        clc;
        if (true)
            disp('Episode: ');
            disp(i);
            disp('Survival Actions: ');
            disp(actionNr);
            disp('Best Survival Actions: ')
            disp(max(Episodes));
        end
    end
    sPrimCost = [(gamma*1*(abs(sPrim(2:end,3)) > allowedPoleAngle | abs(sPrim(2:end,1)) > allowedCartPos));1];
    Qold = dot(Qvalues,actionInfo(:,2:3),2);
    Qnext = [dot(Qvalues(2:end,:),actionInfo(2:end,2:3),2); 0];
    Qnew = (1-alpha)*(Qold)+alpha*(sPrimCost+gamma*Qnext);
    
    if length(Qnew) >= 200*i 
        trainSetStruct = cvpartition(Qnew(200*(i-2)+1:200*i,:),'HoldOut',200);
        trainBitVec = trainSetStruct.test;
        trainIdx = find(trainBitVec == 1);
        %trainSet = [trainSet; ExpPool(trainIdx,:)];
        [net, tr, output, error] = adapt(net, StateActionPair', Qnew');
    end
end