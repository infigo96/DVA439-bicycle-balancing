function experience = rand_experience()
load('FuzzyBalance.mat');

episode = 0;
all_count = 0;
preState = [0,0,0,0];
currentState = preState;
nextState = preState;
actions = linspace(10, -10, 2);

while episode < 5
    
    episode = episode + 1;
    count = 0;
    currentState = [(1 - 2*rand), 0, (0.05-0.1*rand),  0];
    
    while (abs(currentState(1)) <= 2.5 && abs(currentState(3)) <= 0.75)
        all_count = all_count + 1;
        count = count + 1;
        
        preState = currentState;
        
        action = evalfis(FuzzyBalance, [currentState(1), currentState(3)]);
        %action = actions(floor(2*rand)+1);
        currentState = SimulatePendel(action, preState(1), preState(2), preState(3), preState(4));
        experience(:,all_count) = [preState, currentState, action];
        
    end
    
    disp(['Round: ', num2str(episode), ' Collected: ', num2str(count), ' experiences']);
    
end

end