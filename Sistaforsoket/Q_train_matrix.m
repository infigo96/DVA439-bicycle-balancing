function  [new_net, perf] = Q_train_matrix(old_net,experience)
a = 0.2; %learning rate

[size_x,size_y] = size(experience);

currentState = experience(1:4,:);
nextState = experience(5:8,:);
action = experience(9,:);
ten = 10*ones(1, size_y);

cost1 = 100*((abs(nextState(1,:)) >= 2.4) | (abs(nextState(3,:)) >= 0.7));
Q1 = old_net([nextState; ten]);
Q2 = old_net([nextState; -ten]);
Q = min([Q1; Q2]);
cost2 = 0.9*Q + 10*((abs(nextState(1,:)) < 2.4 & abs(nextState(1,:)) >= 0.05) | (abs(nextState(3,:)) < 0.7 & abs(nextState(3,:)) >= 0.05));
cost3 = ((abs(nextState(1,:)) >= 0.05) | (abs(nextState(3,:)) >= 0.05));

input = [currentState; action];
updateCost = cost1+cost2;
output = (1-a)*Q + a*updateCost;
output = output.*cost3;

new_net = train_rprop(input, output);
Q1 = new_net([nextState; ten]);
Q2 = new_net([nextState; -ten]);
Q = min([Q1; Q2]);
perf = perform(new_net,output,Q);
end