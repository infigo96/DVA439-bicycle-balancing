clear, clc, close all
load('SuperNet.mat');
actions = linspace(-10, 10, 2);

%% Setup pendulum plot
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
pause(2)

currentState = [1-2*rand, 0, 0.05-0.1*rand, 0];
i = 0;
t = 0;
tic;
while(abs(currentState(1)) <= 2.4 && abs(currentState(3)) <= 0.7 && t < 45)
    i = i + 1;
    
    set(f,'XData',[currentState(1) currentState(1)+ sin(currentState(3))]); %x pos of stick
    set(g,'XData',currentState(1)); %x pos of dot
    set(f,'YData',[0 cos(currentState(3))]); %y pos of stick
    
    [Q, Q_index] = min([abs(net([currentState'; 10])) abs(net([currentState'; -10]))]);
    nextState = SimulatePendel(actions(Q_index),currentState(1),currentState(2),currentState(3),currentState(4));
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
    t = toc;
    disp(t);
    
    pause(0.02)
    
    grap(i,1) = t;
    grap(i,2) = currentState(1);
    grap(i,3) = currentState(3)*180/pi;
end


%% Plot stats

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