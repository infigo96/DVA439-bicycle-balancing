clc, clear, close all
warning('off', 'all')

%% Variables
actions = linspace(-10, 10, 2);
train = 1; %1 for training and 0 for adapting
iterations = 1;
restarts = 0;
restart = 0;
success = 1;

while iterations <= 200
    %% Step 1 - Collect random experiences
    experience = rand_experience;
    [net_input, net_output] = rand_experience_transfer(experience);
    
    net = train_rprop(net_input, net_output);
    %% Step 2 - Do iterations with random experiences
    for k = 1:1
        [net, perf] = Q_train_matrix(net, experience);
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
    trainingNr = 1;
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
            disp("Successful nets: ");
            disp(success);
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
                [net, perf] = Q_train_matrix(net, experience);
                %train = 0;
            else
                [net, perf] = Q_adapt_matrix(net, experience);
            end
            experience_count = 0;
            stepz(trainingNr) = steps;
            perfz(trainingNr) = perf;
            trainingNr = trainingNr + 1;
        end
        
    end
    if done == 1
        stats(success, 1) = toc;
        stats(success, 2) = episode;
        stats(success, 3) = restarts;
        stepStats{success} = stepz;
        perfStats{success} = perfz;
        success = success + 1;
        clear experience;
        experience = [];
    end
    if restart == 1
        restarts = restarts + 1;
        restart = 0;
        clear_all;
    end
    iterations = iterations + 1;
end
