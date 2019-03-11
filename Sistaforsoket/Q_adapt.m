function  new_net = Q_iterations(old_net,experience)

[size_x,size_y] = size(experience);
fail = 0;

for i = 1:size_y
    currentState = experience(1:4,i);
    nextState = experience(5:8,i);
    action = experience(9,i);
    
    if(abs(nextState(1)) >= 20 || abs(nextState(3)) >= 0.6)
        fail = 0;
        cost = 1;
    elseif(abs(nextState(1)) <= 0.05 && abs(nextState(3)) <= 0.05)
        fail = 0;
        cost = 0;
    else
        %Q = min([old_net([nextState; 10]) old_net([nextState; -10])]);
        fail = fail + 1;
        cost = abs(nextState(3))-0.05;
    end
    
    input(:, i) = [currentState; action];
    output(:, i) = cost;
    
end

new_net = adapt(old_net, input, output);
end