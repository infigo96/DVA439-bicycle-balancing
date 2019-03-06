This folder contain a control loop structure and all files needed to simulate an Autonomous Bicycle in simulation with MATLAB Simulink.

It contain two different models with three different speed modifications;
1. A detailed MSC ADAMS model Plant (8km/h, 12km/h and 15km/h)
2. A simplified Whipple model Plant (8km/h, 12km/h and 15km/h)

Run the 'Setup.m' file from MATLAB and follow the instructions displayed in the 'Commando Window' to select model and speed.
When you have selected model and speed wait for Simulink to open de selected control loop and press 'Run'.

To run the MSC ADAMS plant the computer have to have ADAMS VIEW installed.
See this link to download, http://www.mscsoftware.com/page/adams-student-edition, requires that you fix a student licence.

NOTE: 'DynamicModelParameters.m' re-appear in all folders but differs depending on which speed modification that has been selected.