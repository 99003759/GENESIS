
%%Indiviual work
%Title:Control System -Lateral control -Second Order System
%Author:Amit Kumar
%Ps No: 99003775
%Date:14/04/2021
%Version 1.0

%%Transfer function for On_off or Bang-bang,or Two-Step Controller=H(s)=(K/T.s+1)*e^-r.s
%Variable description for Control Transfer Function
%Where r for tau value k is gain and T is time constant
%The time constant is a measure of the capacitance of the system. The higher the time constant, 
%the longer it takes for the system to react to changing inputs or disturbances.
%In most of the control systems with feedback loop, the system can not respond instantly
%to any disturbance and it takes time (delay) until the controller output has any effect on
%the measured (plant) output. This time delay is know as dead time. 


%Implementations
%Ideal Equation
% Equation1 = m*V*(d(beta)/dt) + m*V_r = Y_beta * beta + Y_r * r + Y_delta * delta + F_ya + m*g*theta
% Equation2 = I_zz * ((dr)/(dt)) = N_beta *beta + N_r * r + N_delta *Delta - (c-a) * F_ya

%%
%Roots: 
%Roots for On-Off Controller is 
%pole=-1/T;
%Zero=-1/r;

%   System with V = 100m/s:
%       1) Zero = 103.1148
%       2) Pole = -0.0305+0.1538i, -0.0305-0.1538i 

% System with V = 50m/s:
%       1) Zero = 51.5401
%       2) Pole = -0.0440+0.1535i, -0.0440-0.1535i

%%Variable Description
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

%%Math Analysis
%Independend: Time(t)
%Dependend:Vehicle side slip angle (Beta), Front Steer angle (Delta)
%Constant: Damping in Sideslip (Ybeta), Lateral Force/Yaw Coupling(Yr)
% Control Force (Ydelta), Directional Stability (Nbeta),
% Yaw Damping (Nr), Control Moment(Ndelta).

%%Plant Descripation
%Implementaions1
%This Plant is valid for any type of Vehicle
%The on-off control is the simplest form of a controller,
%which switches ON when the error is positive and switches OFF 
%when the error is zero or negative. An on-off controller doesn’t 
%have intermediate states but only fully ON or fully OFF states. 
%Due to the switching logic, an on-off controller is often called a bang-bang controller or a two-step controller.
clc;
K=0.8;
T=0.60;
r=3;
M=K*exp(-r);
D=T+1;
Ydelta = 2461;
m = 1775;
V = 100;
Nr = -67.06;
Ndelta = 2803.079;
Yr = 0.46384;
Izz = 1960;
Ybeta = -4772;
Nbeta = 46.38;
sys1 = tf([((M*(Ydelta)/(m*V))),M*(-((Nr*Ydelta)+(Ndelta*((m*V)-Yr))))/...
    (Izz*m*V)],[1*D,(-(Nr/Izz)-(Ybeta/(m*V)))*D,((Nr*Ybeta)+...
    (Nbeta*((m*V)-Yr)))*D/(Izz*m*V)])
figure(1);
subplot(2,2,1);
impulse(sys1);
title('Impulse Input for k');
subplot(2,2,2);
step(sys1);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]=tf2zp([((M*(Ydelta)/(m*V))),M*(-((Nr*Ydelta)+(Ndelta*((m*V)-Yr))))/...
    (Izz*m*V)],[1*D,(-(Nr/Izz)-(Ybeta/(m*V)))*D,((Nr*Ybeta)+...
    (Nbeta*((m*V)-Yr)))*D/(Izz*m*V)])
pzmap(sys1)
subplot(2,2,4);
bode(sys1)
hold on;
S = stepinfo(sys1)


V1 = 50;

sys2 = tf([((M*(Ydelta)/(m*V1))),M*(-((Nr*Ydelta)+(Ndelta*((m*V1)-Yr))))/...
    (Izz*m*V1)],[1*D,(-(Nr/Izz)-(Ybeta/(m*V1)))*D,((Nr*Ybeta)+...
    (Nbeta*((m*V1)-Yr)))*D/(Izz*m*V1)])

figure(2);
subplot(2,2,1);
impulse(sys2);
title('Impulse Input for k');
subplot(2,2,2);
step(sys2);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]=tf2zp([((M*(Ydelta)/(m*V1))),M*(-((Nr*Ydelta)+(Ndelta*((m*V1)-Yr))))/...
    (Izz*m*V1)],[1*D,(-(Nr/Izz)-(Ybeta/(m*V1)))*D,((Nr*Ybeta)+...
    (Nbeta*((m*V1)-Yr)))*D/(Izz*m*V1)])
pzmap(sys2)
subplot(2,2,4);
bode(sys2)
hold on;
S = stepinfo(sys2)

%%Analysis
%If we take Gain  value and Time constant value as zero we  get values of  
%Rise time,Overshoot and peak time zero
%Not changes in UnderShoot
%If Velocity decrease Frequency Increases
%poles are complex  cojugate  at origin due to that system is
%marginal stable
%When velocity is more RiseTime is less and vise versa
%when Velocity of vehicle  is less Settling time is less
%Undershoot  is independent to vehicle speed
%If velocity is larger peaktime is more 

