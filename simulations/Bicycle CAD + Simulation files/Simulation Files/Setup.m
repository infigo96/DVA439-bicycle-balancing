close all
clear all
clc

%% Setup path and bicycle parameters
cd 'C:\Users\Daniel\Documents\GitKraken\DVA439-bicycle-balancing\simulations\Bicycle CAD + Simulation files\Simulation Files' % Change this to the directory your "Lets Play" Folder is located.

%% Start project
disp('1: Adams, 2: 1: Whipple')
model = input('Choose model: '); 

disp('1: 8km/h case, 2: 12km/h case, 3: 15km/h case')
cases = input('Choose case: ');
switch model
    case 1
        cd 'Adams_model' 
        switch cases
           case 1   % Bicycle model desigend to run at 8km/h
              cd '8km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              Nonlinear_Torque_8km
              disp('>> Dynamic model loaded')
              RTS_8km
              disp('>> 8km/h Plant: Ready')
           case 2   % Bicycle model desigend to run at 12km/h
              cd '12km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              Nonlinear_Torque_12km
              disp('>> Dynamic model loaded')
              RTS_12km
              disp('>> 12km/h Plant: Ready')
           case 3   % Bicycle model desigend to run at 15km/h
              cd '15km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              Nonlinear_Torque_15km
              disp('>> Dynamic model loaded')
              RTS_15km
              disp('>> 15km/h Plant: Ready')
           otherwise
              disp('It is not that hard to choose between 1-3... idiot.');
        end
    case 2
        cd 'Whipple_model'
        switch cases
           case 1   % Bicycle model desigend to run at 8km/h
              cd '8km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              disp('>> Dynamic model loaded')
              RTS_8km
              disp('>> 8km/h Plant: Ready')
           case 2   % Bicycle model desigend to run at 12km/h
              cd '12km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              disp('>> Dynamic model loaded')
              torque_controller
              disp('>> 12km/h Plant: Ready')
           case 3   % Bicycle model desigend to run at 15km/h
              cd '15km Plant'
              DynamicModelParameters
              disp('>> Bicycle Parameters loaded')
              disp('>> Dynamic model loaded')
              RTS_15km
              disp('>> 15km/h Plant: Ready')
           otherwise
              disp('It is not that hard to choose between 1-3... idiot.');
        end
    otherwise
        disp('It is not that hard to choose between 1-2... idiot.');
end