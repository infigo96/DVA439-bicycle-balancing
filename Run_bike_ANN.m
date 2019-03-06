close all 
clear 
clc

Titanic = importdata('C:\Users\Daniel\Documents\MATLAB\Assignment 1\assignment 1 titanic.dat');
data = Titanic.data;
TrainSet = data(1:1500, 1:3);
TrainRes = data(1:1500, 4);
TestSet= data(1501:2200, 1:3);
TestRes=data(1501:2200, 4);
Training = 1;
depth = 2;
width = 3;
iter=1000;
TrainFactor = 0.01;

output= ANN_cykel(TrainSet,TestSet,TrainRes,TestRes,Training,depth,width,iter,TrainFactor);