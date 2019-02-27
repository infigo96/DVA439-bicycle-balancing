function [torque] = kit(states, deathStates)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup initial experiences
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TrSet = {};
Input = [];

currentState = states;
% State array
TrSet{1, i} = [currentState];
% Action array
% First index in the action array is never used but needed due to size issues when expanding the episode
TrSet{2, i} = [0];

while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle)
    action = actions(floor(4*rand)+1);
    nextState = SimulatePendel(action*(1 + 0.2*(2*rand - 1)), currentState(1), currentState(2), currentState(3), currentState(4));
    TrSet{1, i} = [TrSet{1, i} ; nextState];
    TrSet{2, i} = [TrSet{2, i}; action];
    currentState = nextState;
end
% Calculate the costs of the future state, use 0.1/0.9 instead of 0/1 to accomodate sigmoid function.
Target = 0.10 + 0.80*(abs(TrSet{1,i}(:,3)) > allowedPoleAngle | abs(TrSet{1,i}(:,1)) > allowedCartPos);
% Recursivly expand the 'input' cell array with 'state, action, cost' - tripplets
Input = [Input; TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:) Target(2:end)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initiate network
% Random weight/bias initiation
% Training fuction can be set inside initNN()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net = initNN(Input(:,1:5)', Input(:,6)', [10 10]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q-fitted training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Used to indicate savepoints of network 
bestActionNr = 0;
% Goal of the training
maxRange = 1000;
for k = 1:12
    for i = 1:100
        currentState = startState;
        TrSet{1, i} = [currentState];
        TrSet{2, i} = [0];
        actionNr = 0;

        while(abs(currentState(1)) <= deathCartPos && abs(currentState(3))<=deathPoleAngle && actionNr < maxRange)

            % Exploration 1/(epsilon) of the time, set false if no exploration
            epsilon = 1+k;
            if(mod(actionNr, epsilon) == 0 && true)
                action = actions(floor(4*rand)+1);
            else
                Q1 = net([currentState actions(1)]');
                Q2 = net([currentState actions(2)]');
                Q3 = net([currentState actions(3)]');
                Q4 = net([currentState actions(4)]');

                [mv, index] = min([Q1 Q2 Q3 Q4]);
                action = actions(index);
            end
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
        Target = 0.05 + 0.90*(abs(TrSet{1,i}(:,3)) > allowedPoleAngle | abs(TrSet{1,i}(:,1)) > allowedCartPos);
        Input = [Input; [TrSet{1,i}(1:end-1,:) TrSet{2,i}(2:end,:)] Target(2:end)];

    end
    [net,tr] = train(net,Input(:,1:5)', Input(:,6)');
end
net = bestNet;
