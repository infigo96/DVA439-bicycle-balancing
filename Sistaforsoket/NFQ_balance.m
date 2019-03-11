clc, clear, close all
warning('off', 'all')
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

%% Variables
actions = linspace(-10, 10, 2);
train = 1; %1 for training and 0 for adapting

%% Step 1 - Collect random experiences
experience = rand_experience;
[net_input, net_output] = rand_experience_transfer(experience);

net = train_rprop(net_input, net_output);
%% Step 2 - Do iterations with random experiences
for k = 1:1
    net = Q_train_matrix(net, experience);
end

%% Step 3 - Simulate and gather new experience
episode = 0;
experience_count = 0;
exploration = 0;
total = 0;
most_steps = 0;
clear experience;
experience = [];
done = 0;
train = 1;
while done == 0%round < 100  %change later
    
    episode = episode + 1;
    currentState = [0, 0, (0.05-0.1*rand), 0];
    steps = 0;
    
    while (abs(currentState(1)) <= 2.5 && abs(currentState(3)) <= 0.75 && done == 0)
        
        % Counters
        total = total + 1;
        steps = steps + 1;
        experience_count = experience_count + 1;
        
        % Simulate
        set(f,'XData',[currentState(1) currentState(1)+ sin(currentState(3))]); %x pos of stick
        set(g,'XData',currentState(1)); %x pos of dot
        set(f,'YData',[0 cos(currentState(3))]); %y pos of stick
        
        % Step 4 - Implement Policy or exploration
 
        rand_nr = rand;
        if rand_nr >= 0.9
            action = 20*rand-10;
            exploration = exploration + 1;
        else
            [Q, Q_index] = max([net([currentState'; 10]) net([currentState'; -10])]);
            action = actions(Q_index);
        end
        
        nextState = SimulatePendel(action,currentState(1), currentState(2),currentState(3),currentState(4));
        pause(0.02);
        
        % Step 5 - Collect new experience
        new_experience = [nextState'; currentState'; action];
        currentState = nextState;
        
        experience = [experience new_experience];
        
        if steps > most_steps
            best_net = net;
            most_steps = steps;
        end
        
%         if max(size(experience)) > 999
%             tmp = experience(:,max(size(experience))/2:end);
%             clear experience;
%             experience = tmp;
%         end
%         
        if steps > 499
            done = 1;
            atRound = episode;
        end
        
        % Displays
        clc
        disp("Round: ");
        disp(episode);
        disp("Exp: ");
        disp(experience_count);
        disp("Steps: ");
        disp(steps);
        disp("Most Steps Taken: ");
        disp(most_steps);
        disp("Exploration: ");
        disp(100*exploration/total);
        
    end
    
    if experience_count > 100
        if train == 1
            net = Q_train_matrix(net, experience);
            %train = 0;
        else
            net = Q_adapt_matrix(net, experience);
        end
        experience_count = 0;
    end
    
    stepz(episode) = steps;
end

%% Simulate

net = best_net;
currentState = [rand-0.5, 0, 0.1*rand-0.05, 0];
i = 0;
goalLenght = 2000;
while(abs(currentState(1)) <= 2.4 && abs(currentState(3)) <= 0.7)
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
    disp(i*0.02);
    
    pause(0.02)
    
    grap(i,1) = i*0.02;
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
scatter(1:max(size(stepz)), stepz);
title(['Finished goal of 500 steps at round: ',num2str(atRound)]);

warning('on', 'all');

