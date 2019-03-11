%One script to rule them all
clear;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cartpole state limiters and actions constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
startState = [0 0 0 0];
Untitled2;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q-fitted training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Used to indicate savepoints of network


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
        [mv, index] = max([net(currentState')]); % net([currentState actions(3)]') net([currentState actions(4)]')
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