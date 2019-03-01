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
actions = [-force, -force/2, force/2, force]; % Either force backward or forward
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
trainFcn = 'trainrp';
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
    currentState = [0.4*rand-0.2, 0.2*rand-1, (2*pi*rand-pi)/30,(2*pi*rand-pi)/30];
    actionNr = 0;
    
    while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && i <= 300)
        
        action = actions(floor(4*rand) + 1);
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
for k = 1:15
    speedUp = 0;
    for i = 1:20+10*k
        currentState = startState;
        TrSet{1, i} = [currentState];
        TrSet{2, i} = [0];
        actionNr = 0;
        
        while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && actionNr < maxRange)
            
            % Exploration 1/(epsilon) of the time, set false if no exploration
            epsilon = 5+k;
            action = actions(floor(4*rand)+1);
            %                 Q1 = net([currentState actions(1)]');
            %                 Q2 = net([currentState actions(2)]');
            %                 Q3 = net([currentState actions(3)]');
            %                 Q4 = net([currentState actions(4)]');
            
            %    [mv, index] = min([net([currentState actions(1)]') net([currentState actions(2)]') net([currentState actions(3)]') net([currentState actions(4)]')]);
            %    action = actions(index);
            
            %Next state is suspect to a random noise with magnitude 20% of action '*(1 + 0.2*(2*rand - 1))'
            nextState = SimulatePendel(action, currentState(1), currentState(2), currentState(3), currentState(4));
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
                disp(bestActionNr)
            end
            %Set display of external loop on
            if (true)
                disp('Training Iteration: ')
                disp(k-1)
            end
        end
        
        %Save best net
        if actionNr > bestActionNr
            bestNet = net;
            bestActionNr = actionNr;
        end
        % Calculate cost of next state
        %Target = min(net([TrSet{1,i}(:,1:4)' actions(1)]), net([TrSet{1,i}(:,1:4)' actions(2)]), net([TrSet{1,i}(:,1:4)' actions(3)]), net([TrSet{1,i}(:,1:4)' actions(4)]));
        %for(minil = 1:lenght(TrSet{1,i}(1,:)))
        minimididadta = max([net([TrSet{1,i}(2:end,:) actions(1)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(2)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(3)*ones(length(TrSet{1,i}(2:end,1)),1)]') net([TrSet{1,i}(2:end,:) actions(4)*ones(length(TrSet{1,i}(2:end,1)),1)]')])';
        %             Q3 = net([currentState actions(3)]');
        %             Q4 = net([currentState actions(4)]');
        %net([TrSet{1,i}(2:end,:) actions(2)*ones(length(TrSet{1,i}(2:end,1)),1)]')
        Target = -0.05 - 0.1*(abs(TrSet{1,i}(2:end,3)) > allowedPoleAngle | abs(TrSet{1,i}(2:end,1)) > allowedCartPos) + 0.9*minimididadta;
        Input = [TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:)];
        adapt(net, fliplr(Input'),fliplr(Target'));
        if actionNr == 1000
            speedUp = speedUp + 1;
        end
        if speedUp >= floor((20+10*k)/2)
            break;
        end
    end
    %[net,tr] = train(net,Input(:,1:5)', Input(:,6)');
end
net = bestNet;

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
        [mv, index] = max([net([currentState actions(1)]') net([currentState actions(2)]') net([currentState actions(3)]') net([currentState actions(4)]')]);
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