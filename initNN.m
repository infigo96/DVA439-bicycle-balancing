function [net] = initNN(x, t, hiddenLayerSize)

% x - input data.
% t - target data.
% x = Input(:,1:5)';
% t = Input(:,6)';

% Choose a Training Function | help nntrain
trainFcn = 'trainscg';  % resiliant backpropagation.

% Create a Fitting Network
%hiddenLayerSize = [10 10];
net = fitnet(hiddenLayerSize,trainFcn);

% Choose Input and Output Pre/Post-Processing Functions | help nnprocess
net.input.processFcns = {'removeconstantrows','mapminmax'};
net.output.processFcns = {'removeconstantrows','mapminmax'};
net.trainParam.showWindow = false;
% Setup Division of Data for Training, Validation, Testing | help nndivision
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 5/100;

% Choose a Performance Function | help nnperformance
%net.performFcn = 'mse';  % Mean Squared Error
net.performFcn = 'mse';
net.performParam.regularization = 0.1;
net.performParam.normalization = 'none';

% Choose Plot Functions | help nnplot
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotfit'};

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y)
valPerformance = perform(net,valTargets,y)
testPerformance = perform(net,testTargets,y)

%To wiev various plots
if (false)
   % View the Network
   view(net)
   % Plots
   figure, plotperform(tr)
   figure, plottrainstate(tr)
   figure, ploterrhist(e)
   figure, plotregression(t,y)
   figure, plotfit(net,x,t)
end

