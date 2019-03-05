%One script to rule them all
clear;
close all;
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
allowedPoleAngle = pi/30;
deathPoleAngle = pi/5;
allowedCartPos = 0.4;
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
trainFcn = 'trainlm';
hiddenLayerSize = [5 5];

% Create a Fitting Network
net = fitnet(hiddenLayerSize,trainFcn);
net.trainParam.showWindow = false;
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'divideind';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 5/100;
net.performFcn = 'mse';

i = 1;
while i <= 5
    currentState = [0.4*rand-0.2, 0.2*rand-0.1, (2*pi*rand-pi)/30,(2*pi*rand-pi)/30];
    actionNr = 0;
    
    while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && i <= 300)
        
        action = actions(floor(2*rand) + 1);
        nextState = SimulatePendel(action, currentState(1), currentState(2), currentState(3), currentState(4));
        Input(i,1:5) = [currentState action];
        Target(i,1) = rand;
        currentState = nextState;
        i = i + 1;
        
    end
end

[net,tr] = train(net,Input',Target');
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
for i = 1:20000
    currentState = [-0.4 + (0.8)*rand, 0 ,-pi/80 + (pi/40)*rand, 0];
    TrSet{1, i} = [currentState];
    TrSet{2, i} = [0];
    actionNr = 0;

    while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && actionNr < maxRange)


        %[minimididadta, acindex] = max([net([currentState actions(1)]') net([currentState actions(2)]') net([currentState actions(3)]') net([currentState actions(4)]')]);
        [minimididadta, acindex] = max([net([currentState actions(1)]') net([currentState actions(2)]')]);
        %    [mv, index] = min([net([currentState actions(1)]') net([currentState actions(2)]') net([currentState actions(3)]') net([currentState actions(4)]')]);
        %    action = actions(index);

        %Next state is suspect to a random noise with magnitude
        nextState = SimulatePendel(actions(acindex), currentState(1), currentState(2), currentState(3), currentState(4));
        TrSet{1, i} = [TrSet{1, i} ; nextState];
        TrSet{2, i} = [TrSet{2, i}; action];
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

    minimididadta = min([net([TrSet{1,i}(2:end,:) actions(1)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(2)*ones(length(TrSet{1,i}(2:end,1)),1)]') ])'; %net([TrSet{1,i}(2:end,:) actions(3)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(4)*ones(length(TrSet{1,i}(2:end,1)),1)]')

    Target = (abs(TrSet{1,i}(2:end,3)) > allowedPoleAngle | abs(TrSet{1,i}(2:end,1)) > allowedCartPos);
    Target = 1*Target + 0.9*minimididadta*(Target==0);
    Input = [TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:)];
    [net,tr] = adapt(net, fliplr(Input'),fliplr(Target'));
    
    Episodes = [Episodes actionNr];
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
        [mv, index] = max([net([currentState actions(1)]') net([currentState actions(2)]')]); % net([currentState actions(3)]') net([currentState actions(4)]')
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