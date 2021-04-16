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




R1 = 1;
L1 = 0.2;
t1=(L1/R1);

sys1=tf([1/R1],[t1,1]);
title('Step response for 1')
step(sys1)
subplot(3,3,1)
hold on 
title('Impulse response for 1')
impulse(sys1)
subplot(3,3,2)
hold on
[z1,p1,k1]= tf2zp([1/R1],[t1,1]);
Z=zplane(z1,p1);
S1 = stepinfo(sys1)
root1 = (1/t1)*-1



hold on

R2 = 20;
L2 = 0.05;
t2 = (L2/1);

sys2=tf([1/R2],[t2,1]);
title('Step response for 2')
step(sys2)
subplot(3,3,3)
title('Impulse response for 2')
impulse(sys2)
subplot(3,3,4)
[z2,p2,k2]= tf2zp([1/R2],[t2,1]);
zplane(z2,p2)
S2 = stepinfo(sys2);
root2 = (1/t2)*-1;

hold on

R3 = 40;
L3 = 0.8;
t3=(L3/1);
sys3 = tf([1/R3],[t3,1]);
title('Step response for 3')
step(sys3)
subplot(3,3,5)
title('Impulse response for 3')
impulse(sys3)
subplot(3,3,6)
[z3,p3,k3]= tf2zp([1/R3],[t3,1]);
zplane(z3,p3)
S3 = stepinfo(sys3);
root3 = (1/t3)*-1;

