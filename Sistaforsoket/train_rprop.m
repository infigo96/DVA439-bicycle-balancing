function rprop_net = train_rprop(input, output)

% net = newff(input,[12,6,1],{'elliotsig','elliotsig','elliotsig'},'trainrp');
% net.trainParam.showWindow = false;
% net.trainParam.showCommandLine = false;
hiddenLayerSize = [5 5 5 5];
trainFcn = 'trainrp';
net = fitnet(hiddenLayerSize,trainFcn);

net.trainParam.showWindow = false;
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 5/100;
net.performFcn = 'mse';
net.performParam.regularization = 0.1;
net.performParam.normalization = 'none';
% transFcn = 'elliotsig';
% net.layers{1}.transferFcn = transFcn;
% net.layers{2}.transferFcn = transFcn;
% net.layers{3}.transferFcn = transFcn;
net.layers{4}.transferFcn = 'poslin';

net = train(net,input,output);
rprop_net = net;

end