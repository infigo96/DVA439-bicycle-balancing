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
iterations = 1;
restarts = 0;
restart = 0;
while iterations <= 50
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
    fails = 0;
    adapting = 0;
    tic;
    while done == 0 && restart == 0
        
        episode = episode + 1;
        currentState = [0, 0, (0.05-0.1*rand), 0];
        steps = 0;
        
        while (abs(currentState(1)) <= 2.5 && abs(currentState(3)) <= 0.75 && done == 0 && restart == 0)
            
            % Counters
            total = total + 1;
            steps = steps + 1;
            experience_count = experience_count + 1;      
            
            % Step 4 - Implement Policy or exploration
            
            rand_nr = rand;
            if rand_nr >= 0.9
                action = 20*rand-10;
                exploration = exploration + 1;
            else
                [Q, Q_index] = min([net([currentState'; 10]) net([currentState'; -10])]);
                action = actions(Q_index);
            end
            
            nextState = SimulatePendel(action,currentState(1), currentState(2),currentState(3),currentState(4));
            
            % Step 5 - Collect new experience
            new_experience = [nextState'; currentState'; action];
            currentState = nextState;
            
            experience = [experience new_experience];
            
            if steps > most_steps
                best_net = net;
                most_steps = steps;
            end
            
            if steps > 99
                train = 0;
                adapting = 1;
            end
            
            if adapting == 1
                if max(size(experience)) > 999
                    tmp = experience(:,max(size(experience))/2:end);
                    clear experience;
                    experience = tmp;
                end
            end
            
            if steps > 399
                done = 1;
                atRound = episode;
            end
            
            if episode == 200
                restart = 1;
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
            disp("Fails: ");
            disp(fails);
            disp("Iteration: ");
            disp(iterations);
            disp("Restarts: ");
            disp(restarts);
            
        end
        
        if steps < 30
            fails = fails + 1;
        else
            fails = 0;
        end
        
        if experience_count > 100 && done == 0
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
    if done == 1
        stats(iterations, 1) = toc;
        stats(iterations, 2) = episode;
        stats(iterations, 3) = restarts;
        stepStats{iterations} = stepz;
        iterations = iterations + 1;
        clear experience;
        experience = [];
    end
    if restart == 1
        restarts = restarts + 1;
        restart = 0;
        clear_all;
    end
end
