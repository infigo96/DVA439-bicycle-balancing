function void = looper()
    close all;
    clc;
    clear;    
    results = [];
    nets = {};
    for j = 1:20
        Cartpole_QFNN;
        Results = [Results; bestActionNr];
        nets = [nets; bestNet];
    end
end