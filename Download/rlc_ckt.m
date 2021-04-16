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


R = [100 200 300];
L = [10e-3 20e-3 30e-3];
C = [100e-6 200e-6 300e-6];

for i = 1:3
    tau = L(i)/R(i);
    T_F = tf([1/(L(i)*C(i))],[1,(1/tau),(1/(L(i)*C(i)))]);
    
    figure(i)
    subplot(2,1,1)
    step(T_F);
   
    subplot(2,1,2)
    impulse(T_F);
    
    [z,p,k]= tf2zp([1/R(i)],[tau,1]);
    zplane(z,p)
    
    zeta = (R(i)/2)*(sqrt(C(i)/L(i)));
    w_n  = (1/(sqrt(L(i)*C(i))));
    
end
