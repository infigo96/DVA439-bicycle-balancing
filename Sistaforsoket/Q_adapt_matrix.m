function  new_net = Q_adapt_matrix(old_net,experience)

[size_x,size_y] = size(experience);

currentState = experience(1:4,:);
nextState = experience(5:8,:);
action = experience(9,:);
ten = 10*ones(1, size_y);

cost1 = -1*((abs(nextState(1,:)) >= 2.4) | (abs(nextState(3,:)) >= 0.7));
Q1 = old_net([nextState; ten]);
Q2 = old_net([nextState; -ten]);
Q = max([Q1 Q2]);
cost2 = 0.9*Q - 0.01*((abs(nextState(1,:)) < 2.4 & abs(nextState(1,:)) >= 0.05) | (abs(nextState(3,:)) < 0.7 & abs(nextState(3,:)) >= 0.05));

input = [currentState; action];
output = cost1+cost2;

new_net = adapt(old_net, input, output);
end