%% Control system: 1st order system ANALYSIS
% Name: Rajendra Hanagodi
% Ps no: 99003740
% Date :07/04/2021
% version:1.0
%% plant description
%This plant has a model for RL circuit.the 3 different values of R and L are analyzed 
% Equation

%% Math analysis
% I/D/C
%roots 


R = [100 200 300 400 500];
L = [10e-3 20e-3 30e-3 40e-3 50e-3];
C = [100e-6 200e-6 300e-6 400e-6 500e-6];
zeta = [1 0.5 1.5 -0.5 -2];

for i = 1:5
 
    w_n  = (1/(sqrt(L(i)*C(i))))
    root1 = (((zeta(i)*w_n)* -1) + (w_n*(sqrt((zeta(i)*zeta(i))-1))))
    root2 = (((zeta(i)*w_n)* -1) - (w_n*(sqrt((zeta(i)*zeta(i))-1))))
    zplane(root1);
    xlim([-1500 1500]);
    ylim([-1500 1500]);
    hold on
    zplane(root2);
    xlim([-1500 1500]);
    ylim([-1500 1500]);
end
