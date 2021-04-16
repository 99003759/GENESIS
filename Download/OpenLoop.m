%% Lateral Dynamics Control- Open Loop
% Author: Pushkar Antony
% PS Number: 99003729
% Date: 12th April 2021.
% Version: 1.0.

%% Plant Description
% Vertical dynamics, or ride dynamics, basically refers to the vertical 
% response of the vehicle to road disturbances. Longitudinal dynamics 
% involves the straight-line acceleration and braking of the vehicle. 
% Lateral dynamics is concerned with the vehicle's turning behavior.
%--------------------------------------------------------------------------
% Equation1: Ybeta*Beta + Yr*r + Ydelta*delta + Fya + m*g*theta =
%               m*V*d(Beta)/dt + m*V*r
% Equation2: Nbeta*Beta + Nr*r + Ndelta*delta - (c-a)*Fya = Izz*dr/dt
%--------------------------------------------------------------------------
% Variables: 
%   Ybeta = Cf+Cr --> Damping - in - Sideslip
%   Yr = (aCf - bCr)/V --> Lateral Force/Yaw Coupling
%   Ydelta = ~Cf --> Control Force
%   Nbeta = a*Cf - b*Cr --> Directional Stability
%   Nr = (a^2)Cf + (b^2)Cr --> Yaw Damping
%   Ndelta = -aCf --> Control Moment
%--------------------------------------------------------------------------
% Values: Ydelta = 2461; m = 1775; V = 100; Nr = -67.06; Ndelta = 2803.079;
%         Yr = 0.46384; Izz = 1960; Ybeta = -4772; Nbeta = 46.38; V1=50;
%         Yr1 = 0.92768; Nr1 = -134.12;

%% Open Loop Control
% System with Velocity of 100m/s:-
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
sys = tf([((Ydelta)/(m*V)),-((Nr*Ydelta)+(Ndelta*((m*V)-Yr)))/...
    (Izz*m*V)],[1,(-(Nr/Izz)-(Ybeta/(m*V))),((Nr*Ybeta)+...
    (Nbeta*((m*V)-Yr)))/(Izz*m*V)])
figure(1);
subplot(2,2,1);
impulse(sys);
title('Impulse Input for k');
subplot(2,2,2);
step(sys);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([((Ydelta)/(m*V)),-((Nr*Ydelta)+(Ndelta*((m*V)-Yr)))/...
    (Izz*m*V)],[1,(-(Nr/Izz)-(Ybeta/(m*V))),((Nr*Ybeta)+...
    (Nbeta*((m*V)-Yr)))/(Izz*m*V)])
pzmap(sys)
hold on;
S = stepinfo(sys)
%--------------------------------------------------------------------------
% System with velocity of 50m/s:-
V1 = 50;
Yr1 = 0.92768;
Nr1 = -134.12;
sys = tf([((Ydelta)/(m*V1)),-((Nr1*Ydelta)+(Ndelta*((m*V1)-Yr1)))/...
    (Izz*m*V1)],[1,(-(Nr1/Izz)-(Ybeta/(m*V1))),((Nr1*Ybeta)+...
    (Nbeta*((m*V1)-Yr1)))/(Izz*m*V1)])
figure(2);
subplot(2,2,1);
impulse(sys);
title('Impulse Input for k');
subplot(2,2,2);
step(sys);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([((Ydelta)/(m*V1)),-((Nr*Ydelta)+(Ndelta*((m*V1)-Yr)))/...
    (Izz*m*V1)],[1,(-(Nr/Izz)-(Ybeta/(m*V1))),((Nr*Ybeta)+...
    (Nbeta*((m*V1)-Yr)))/(Izz*m*V1)])
pzmap(sys)
hold on;
S = stepinfo(sys)

%% Math Analysis:
% Independent: Time(t)
% Dependent: Vehicle side slip angle (Beta), Front Steer angle (Delta)
% Constant: Damping in Sideslip (Ybeta), Lateral Force/Yaw Coupling(Yr),
%           Control Force (Ydelta), Directional Stability (Nbeta),
%           Yaw Damping (Nr), Control Moment(Ndelta).
%--------------------------------------------------------------------------
% Roots: 
%   System with V = 100m/s:
%       1) Zero = 103.1148
%       2) Pole = -0.0305+0.1538i, -0.0305-0.1538i 
%   System with V = 50m/s:
%       1) Zero = 51.5401
%       2) Pole = -0.0440+0.1535i, -0.0440-0.1535i
%--------------------------------------------------------------------------
% Time Response Analysis:
%   1)System with V = 100m/s:
%        RiseTime: 7.6539
%        SettlingTime: 126.2645
%        SettlingMin: -89.1467
%        SettlingMax: -41.4693
%        Overshoot: 53.2876
%        Undershoot: 0
%        Peak: 89.1467
%        PeakTime: 21.1043
%   2)System with V = 50m/s:
%        RiseTime: 8.5851
%        SettlingTime: 64.9768
%        SettlingMin: -67.2096
%        SettlingMax: -47.9433
%        Overshoot: 28.6676
%        Undershoot: 0
%        Peak: 67.2096
%        PeakTime: 20.3506

%% Comparison Analysis:
% 1) The order of the system is 2nd order.
% When the Velocity of the system is changed, we can get to see some
% changes:
% 2) The system with higher velocity has the highest rise time and reaches
% the peak the fastest.
% 3) That is, the system with the higher velocity is the fastest.
% 4) The system with lesser velocity has the lower settling time, denoting 
% that it is more accurate.
% 5) The system with lesser velocity has lower overshoot percentages.
% 6) The system with higher velocity has the highest peak.