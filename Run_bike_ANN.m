%%
close all 
clear 
clc

%% ANN parameters
depth = 2;
width = 3;
NewTraning = 1; % 1 = Yes (Random weights and biases).

%% Training parameters
Training = 1; % 1 = Yes.
iter=1000; % Training iterations.
TrainFactor = 0.01;

%% Run ANN

%output is predicted value of "TestSet" if training is set to "0".
%NewTraining is set to "0" after training.
[output,NewTraning,w1,w2,w3,bias1,bias2] = ANN_cykel(TrainSet,TestSet,TrainRes,TestRes,Training,depth,width,iter,TrainFactor,NewTraning,w1,w2,w3,bias1,bias2);