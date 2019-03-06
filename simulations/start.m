close all
clear all
clc
%% Setup path and bicycle parameters
cd 'C:\Users\Daniel\Documents\GitKraken\DVA439-bicycle-balancing\simulations\Bicycle CAD + Simulation files\Simulation Files\Adams_model' % Change this to the directory your "Lets Play" Folder is located.

%%
cd '12km Plant'
DynamicModelParameters
disp('>> Bicycle Parameters loaded')
Nonlinear_Torque_12km
disp('>> Dynamic model loaded')
torque_controller
disp('>> 12km/h Plant: Ready')
disp('1: Generate experience 2: Train, 3: Run')
cases = input('Choose case: ');

switch cases
    case 1
        torqueState = 0;
    case 2
        torqueState = 1;
    case 3
        torqueState = 1;
    otherwise
        disp('It is not that hard to choose between 1-3... idiot.');
end
%%
clear simData

for i = 1:5
    sim('torque_controller',1000)
    
    if (i==1)
        simData = yout;
    else
        simData=[simData;yout];
    end
    i
end