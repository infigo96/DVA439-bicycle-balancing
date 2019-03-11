function [input, output] = rand_experience_transfer(experience)

[size_x, size_y] = size(experience);
fail = 0;
for i = 1:size_y
    
    currentState = experience(1:4,i);
    nextState = experience(5:8,i);
    action = experience(9,i);
    
    if(abs(nextState(1)) >= 2.5 || abs(nextState(3)) >= 0.75)
        fail = 0;
        cost = 10;
    elseif(abs(nextState(1)) <= 0.05 && abs(nextState(3)) <= 0.05)
        fail = 0;
        cost = 0;
    else
        fail = fail + 1;
        cost = 1*fail;
    end
    
    input(:, i) = [currentState; action];
    output(:, i) = cost;
    
end

end