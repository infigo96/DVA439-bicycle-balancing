%One script to rule them all
clear;
close all;
warning('off', 'all')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cartpole state limiters and actions constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
startState = [0 0 0 0];
Disc = @(x) 0.9^x;
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
% Setup initial experiences
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
    actionNr = 0;
    
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
% constant weights/biases init to initTarget value. 
if(false)
    factor = 1;
    net.IW{1} = ones(10,5)*factor;
    net.LW{2,1} = ones(10,10)*factor;
    net.LW{3,2} = ones(10,10)*factor;
    % net.LW{4,3} = ones(5,5);
    net.LW{4,3} = ones(1,10)*factor;
    % 
    net.B{1} = zeros(10,1)*factor;
    net.B{2} = zeros(10,1)*factor;
    net.B{3} = zeros(10,1)*factor;
    % net.B{4} = ones(5,1);
    net.B{4} = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q-fitted training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Used to indicate savepoints of network
bestActionNr = 0;
% Goal of the training
maxRange = 2000;
Input = [];
Target = [];
Episodes = [];
errorVec = {};
ExpPool = [];
trainSet = [];
AcChoise = [];
for i = 1:200
    while (length(ExpPool)<=200*i)
        currentState = [-0.4 + (0.8)*rand, 0 ,-pi/80 + (pi/40)*rand, 0]; %[0 0 0 0]; %
        TrSet{1, i} = [currentState];
        TrSet{2, i} = [0];
        actionNr = 0;

        while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && actionNr < maxRange)
            Qvalues = zeros(1,2);
            if (rand < 0.05)
                acindex = ceil(2*rand);
                AcChoise = [AcChoise; acindex 0 0 0];
            else
                Qvalues = [abs(net([currentState actions(1)]')) abs(net([currentState actions(2)]'))];
            
                if Qvalues(1) == Qvalues(2)
                    acindex = ceil(2*rand);
                else
                    [minimididadta, acindex] = max(Qvalues);
                    AcChoise = [AcChoise; acindex 1 Qvalues];
                end
            end
            %    [mv, index] = min([net([currentState actions(1)]') net([currentState actions(2)]') net([currentState actions(3)]') net([currentState actions(4)]')]);
            %    action = actions(index);
            %Next state is suspect to a random noise with magnitude 0.2% *(1+0.2*(rand-0.5))
            nextState = SimulatePendel(actions(acindex)*(1+0.2*(rand-0.5)), currentState(1), currentState(2), currentState(3), currentState(4));
            TrSet{1, i} = [TrSet{1, i} ; nextState];
            TrSet{2, i} = [TrSet{2, i}; actions(acindex)];
            currentState = nextState;
            actionNr = actionNr + 1;

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
        % Calculate cost of next state
        minimididadta = max(abs([net([TrSet{1,i}(2:end,:) actions(1)*ones(length(TrSet{1,i}(2:end,1)),1)]')' net([TrSet{1,i}(2:end,:) actions(2)*ones(length(TrSet{1,i}(2:end,1)),1)]')']),[],2)'; %net([TrSet{1,i}(2:end,:) actions(3)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(4)*ones(length(TrSet{1,i}(2:end,1)),1)]')
        minimididadta(end) = 1;
        currVal = net([TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:)]');
        Target = 0.9*currVal'+0.1*(-0.9*minimididadta'+(abs(TrSet{1,i}(2:end,3)) > allowedPoleAngle | abs(TrSet{1,i}(2:end,1)) > allowedCartPos)); % add for Q:learn 
        Input = [TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:)];

        ExpPool = [ExpPool; TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:) Target];
        Episodes = [Episodes actionNr];
    end
    
    %  Update experiences based on new qutable (bad idea?)
    %         minimididadta = min(abs([net([ExpPool(:,1:4) actions(1)'*ones(length(ExpPool),1)]')' net([ExpPool(:,1:4) actions(2)'*ones(length(ExpPool),1)]')' ]),[],2)'; %net([TrSet{1,i}(2:end,:) actions(3)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(4)*ones(length(TrSet{1,i}(2:end,1)),1)]')
    %         ExpPool(:,6) = 0.8*minimididadta'+0.2*(abs(ExpPool(1:end,3)) > allowedPoleAngle | abs(ExpPool(1:end,1)) > allowedCartPos);

    if (mod(i,50) == 0) %ExpPool(:,1:5) ones(length(ExpPool)*action(1),1)),1)
        trainSetStruct = cvpartition(ExpPool(:,6),'HoldOut',length(ExpPool)-1);
        trainBitVec = trainSetStruct.test;
        trainIdx = find(trainBitVec == 1);
        trainSet = [trainSet; ExpPool(trainIdx,:)];

        [net,tr, output, error] = train(net, trainSet(:, 1:5)',trainSet(:,6)');
        errorVec = [errorVec; error];
    else
        trainSetStruct = cvpartition(ExpPool(:,6),'HoldOut',200);
        trainBitVec = trainSetStruct.test;
        trainIdx = find(trainBitVec == 1);
        trainSet = [trainSet; ExpPool(trainIdx,:)];

        [net,tr, output, error] = adapt(net, trainSet(:, 1:5)',trainSet(:,6)');
        errorVec = [errorVec; error];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

currentState = startState;
i = 0;
goalLenght = 2000;
while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && i <= goalLenght)
    i = i + 1;
    
    set(f,'XData',[currentState(1) currentState(1)+ sin(currentState(3))]); %x pos of stick
    set(g,'XData',currentState(1)); %x pos of dot
    set(f,'YData',[0 cos(currentState(3))]); %y pos of stick
    
    if(mod(i, 3) == 0)
        action = 10*rand - 5
    else
        [mv, index] = min([net([currentState actions(1)]') net([currentState actions(2)]')]); % net([currentState actions(3)]') net([currentState actions(4)]')
        action = actions(index);
    end
    nextState = SimulatePendel(action*(1 + 0.2*(2*rand - 1)), currentState(1), currentState(2), currentState(3), currentState(4));
    currentState = nextState;
    
    %Update
    clc;
    disp('Cart distance is: ');
    disp(currentState(1));
    disp('Cart speed is: ');
    disp(currentState(2));
    disp('Angle is: ');
    disp(180/pi*currentState(3));
    disp('Angle velocity is: ');
    disp(currentState(4));
    disp('Survival time');
    disp(i*0.02);
    
    pause(0.02)
    
    grap(i,1) = i*0.02;
    grap(i,2) = currentState(1);
    grap(i,3) = currentState(3)*180/pi;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(grap(:,2),grap(:,1));
ylabel("time (s)");
xlabel("Cart position from center (m)");
xlim([-2.4,2.4]);
title("Cart position");
figure;
plot(grap(:,3),grap(:,1));
ylabel("time (s)");
xlabel("Rod angle (Degrees)");
xlim([-12,12]);
title("Rod angle");
toPlot = 0;
disp('bestNr')
disp(bestActionNr)
figure;
plot(Episodes);