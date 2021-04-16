%% Control System - Lateral Control - Second Order System 
%Name - Amiya Kumar Panda 
%PS No - 99003783
%Date - 14/04/2021
%Version - 1.1.1

%% Plant Description
%This plant has been modeled for lateral contol of any vehicle.
%In this model two different values of velocity has been taken to get the better result analysis. 

% Implementation
% Ideal Equation- 
% Equation1 = m*V*(d(beta)/dt) + m*V_r = Y_beta * beta + Y_r * r + Y_delta * delta + F_ya + m*g*theta
% Equation2 = I_zz * ((dr)/(dt)) = N_beta *beta + N_r * r + N_delta *Delta - (c-a) * F_ya

%Variable Description 
%m - Total Vehicle mass(kg)
%V - Magnitude of vehicle velocity (v)
%Y_delta - Control force derivative (Newton/rad)
%N_r - Yaw damping derivative (Newton-metre-s/rad)
%N_delta - Control Moment Derivative (Newton-metre/rad)
%r - Yaw velocity (rad/sec)
%Vr - Velocity of the rear tire (metre/sec)
%theta - Road side Slope (rad)
%g - Acceleration due to gravity (metre/s^2)
%c - Distance from front axle to aerodynamics side force (metre)
%a - Distance from mass center to front axle (metre)
%I_zz - Total vehicle yaw mass moment of inertia (kg-metre^2)
%Y-r - Lateral  force yaw coupling derivative (Newton-sec/rad)
%Y-beta - Damping in sideslip derivative (Newton/rad)
%beta - Vehicle side slip angle (rad)
%F_ya - Aerodynamics side force disturbance (Newton)
%N_beta - Directional stability derivative (Newton-metre/rad)
%% Math analysis

% Independent: Time(t)
% Dependent: Vehicle side slip angle (Beta), Front Steer angle (Delta)
% Constant: Damping in Sideslip (Ybeta), Lateral Force/Yaw Coupling(Yr),Control Force (Ydelta), Directional Stability (Nbeta),Yaw Damping (Nr), Control Moment(Ndelta).

%% Tool Analysis
clear all;
close all;
clc;
Ydelta = 2461;             
m = 1775;
V = 100;
Nr = -67.06;
Ndelta = 2803.079;
Yr = 0.46384;
Izz = 1960;
Ybeta = -4772;
Nbeta = 46.38;

sys = tf([((Ydelta)/(m*V)),-((Nr*Ydelta)+(Ndelta*((m*V)-Yr)))/(Izz*m*V)],[1,(-(Nr/Izz)-(Ybeta/(m*V))),((Nr*Ybeta) + (Nbeta*((m*V)-Yr)))/(Izz*m*V)])
sys_N1=feedback(sys,1)
    [GC_PID,info_PI] = pidtune(sys,'PID');
     sys_N1_PID = feedback(sys * GC_PID,1);
figure(1);
subplot(2,2,1);
impulse(sys_N1_PID);
title('Impulse Input for k');
subplot(2,2,2);
step(sys_N1_PID);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([((Ydelta)/(m*V)),-((Nr*Ydelta)+(Ndelta*((m*V)-Yr)))/(Izz*m*V)],[1,(-(Nr/Izz)-(Ybeta/(m*V))),((Nr*Ybeta) + (Nbeta*((m*V)-Yr)))/(Izz*m*V)])
pzmap(sys_N1_PID)
subplot(2,2,4);
bode(sys_N1_PID)
hold on;
S = stepinfo(sys_N1_PID)


V1 = 50;
sys1 = tf([((Ydelta)/(m*V1)),-((Nr*Ydelta)+(Ndelta*((m*V1)-Yr)))/(Izz*m*V1)],[1,(-(Nr/Izz)-(Ybeta/(m*V1))),((Nr*Ybeta) + (Nbeta*((m*V1)-Yr)))/(Izz*m*V1)])
sys_N2=feedback(sys1,1)
[GC_PID,info_PI] = pidtune(sys1,'PID');
     sys_N2_PID = feedback(sys1 * GC_PID,1);
figure(2);
subplot(2,2,1);
impulse(sys_N2_PID);
title('Impulse Input for k');
subplot(2,2,2);
step(sys_N2_PID);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([((Ydelta)/(m*V1)),-((Nr*Ydelta)+(Ndelta*((m*V1)-Yr)))/(Izz*m*V1)],[1,(-(Nr/Izz)-(Ybeta/(m*V1))),((Nr*Ybeta) + (Nbeta*((m*V1)-Yr)))/(Izz*m*V1)])
pzmap(sys_N2_PID)
subplot(2,2,4);
bode(sys_N2_PID)
hold on;
S = stepinfo(sys_N2_PID)

%% Comparison Analysis
%Speed 
% As the rising time is less in the system 2 (V=50). So, we can conclude
% that less the velocity of the system response will be fast.

%Accuracy
% As the settlimng time is less for the system 2 as compare to the system1.
% Here, we can concluded that less the velocity the response settles very fast.

% Stablity
%As the poles are complex conjugate for both the system and the poles are
%left side of the s-plane. The system is stable. 
% As the no. of zeros are also less than the no. of poles the system gets stable.
