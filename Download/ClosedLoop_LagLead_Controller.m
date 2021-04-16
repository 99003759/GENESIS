%% Lateral Dynamics Control- Closed Loop
% Author: Pushkar Antony
% PS Number: 99003729
% Date: 14th April 2021.
% Version: 1.0.

%% Plant Description
% Introduction:
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

%% Closed Loop (negative feedback) without Controller :-
clc;
transfn = tf([0.01386,-1.43],[1,0.07496,-1.40542])
figure(1);
subplot(2,2,1);
impulse(transfn);
title('Impulse Input without controller');
subplot(2,2,2);
step(transfn);
title('Step Input without controller');
subplot(2,2,3);
[z,p,k]= tf2zp([0.01386,-1.43],[1,0.07496,-1.40542])
pzmap(transfn)
title('pz map without controller');
subplot(2,2,4);
bode(transfn)
[Gm,Pm,Wcg,Wcp] = margin(lag)
title('Bode plot without controller');
hold on;
S = stepinfo(transfn)


%% Closed Loop (negative feedback) with Controller:-
% System with lag-controller/compensator:-
sys = tf([0.01386,-1.43],[1,0.0611,0.02458])
sys2 = tf([1,0.05],[1,0.95])
lag = sys*sys2
figure(2);
subplot(2,2,1);
impulse(lag);
title('Impulse Input for k');
subplot(2,2,2);
step(lag);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([0.01386,-1.42,-0.0715],[1,1.011,0.08263,0.02335])
pzmap(lag)
subplot(2,2,4);
bode(lag)
[Gm,Pm,Wcg,Wcp] = margin(lag)
hold on;
S = stepinfo(lag)
%--------------------------------------------------------------------------
% System with lead-controller/compensator:-
sys = tf([0.01386,-1.43],[1,0.0611,0.02458])
sys2 = tf([1,0.95],[1,0.05])
lag = sys*sys2
figure(3);
subplot(2,2,1);
impulse(lag);
title('Impulse Input for k');
subplot(2,2,2);
step(lag);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([0.01386,-1.417,-1.358],[1,0.1111,0.02763,0.001229])
pzmap(lag)
subplot(2,2,4);
bode(lag)
[Gm,Pm,Wcg,Wcp] = margin(lag)
hold on;
S = stepinfo(lag)
%--------------------------------------------------------------------------
% System with lag-lead controller/compensator:-
sys = tf([0.01386,-1.43],[1,0.0611,0.02458])
sys2 = tf([1,0.95],[1,0.05])
sys3 = tf([1,0.25],[1,0.85])
lag = sys*sys2*sys3
figure(4);
subplot(2,2,1);
impulse(lag);
title('Impulse Input for k');
subplot(2,2,2);
step(lag);
title('Step Input for k');
subplot(2,2,3);
[z,p,k]= tf2zp([0.01386,-1.413,-1.713,-0.3396],[1,0.9611,0.1221,0.02472,0.001045])
pzmap(lag)
subplot(2,2,4);
bode(lag)
[Gm,Pm,Wcg,Wcp] = margin(lag)
hold on;
S = stepinfo(lag)
%% Math Analysis:
% Independent: Time(t)
% Dependent: Vehicle side slip angle (Beta), Front Steer angle (Delta)
% Constant: Damping in Sideslip (Ybeta), Lateral Force/Yaw Coupling(Yr),
%           Control Force (Ydelta), Directional Stability (Nbeta),
%           Yaw Damping (Nr), Control Moment(Ndelta).
%--------------------------------------------------------------------------
% Roots: 
%   1) Closed Loop without controller:
%       1) Zero = 103.1148
%       2) Poles = -1.2236, 1.1486
%   2) Closed Loop with Lag Controller:
%       1) Zeros = 102.5034, -0.0503
%       2) Poles = -0.9499 + 0.0000i, -0.0306 + 0.1538i, -0.0306 - 0.1538i
%   3) Closed Loop with Lead Controller:
%       1) Zeros = 103.186, -0.9495 
%       2) Poles = -0.0305 + 0.1538i, -0.0305 - 0.1538i, -0.0500 + 0.0000i
%   4) Closed Loop with Lag-lead Controller:
%       1) Zeros =  103.1486, -0.9506, -0.2499 
%       2) Poles =  {-0.8500 + 0.0000i, -0.0306 + 0.1538i, 
%                    -0.0306 - 0.1538i, -0.0500 + 0.0000i}
%--------------------------------------------------------------------------
% Time Response Analysis:
%   1) Closed Loop without Controller:
%        RiseTime: NaN
%        SettlingTime: Nan
%        SettlingMin: NaN
%        SettlingMax: NaN
%        Overshoot: NaN
%        Undershoot: Nan
%        Peak: Inf
%        PeakTime: Inf
%   2) Closed Loop with Lag Controller:
%        RiseTime: 2.1472
%        SettlingTime: 138.4252
%        SettlingMin: -9.7437
%        SettlingMax: 0.5176
%        Overshoot: 218.2161
%        Undershoot: 16.9030
%        Peak: 9.7437
%        PeakTime: 12.1189
%   3) Closed Loop with Lead Controller:
%        RiseTime: 20.8356
%        SettlingTime: 96.3507
%        SettlingMin: -1.1153e+03
%        SettlingMax: -929.8799
%        Overshoot: 0.8998
%        Undershoot: 0
%        Peak: 1.1153e+03
%        PeakTime: 70.8488
%   4) Closed Loop with Lag-Lead Controller:
%        RiseTime: 17.9517
%        SettlingTime: 94.2687
%        SettlingMin: -330.5149
%        SettlingMax: -270.3005
%        Overshoot: 1.6628
%        Undershoot: 0
%        Peak: 330.5149
%        PeakTime: 67.8339
%--------------------------------------------------------------------------
% Frequency Response Analysis:
%   1) Closed Loop without controller:
%        Gm = 0.0031
%        Pm = 170.0613
%   2) Closed Loop with Lag Controller:
%        Gm = 0.3266
%        Pm = -137.446
%   3) Closed Loop with lead Controller:
%        Gm = 0.00090467
%        Pm = 148.5963
%   4) Closed Loop with Lag-Lead Controller:
%        Gm = 0.0031
%        Pm = 170.0613
%% Comparison Analysis:
% 1) On giving -ve feedback without any controller, the system goes
% unstable.
% 2) On adding a controller/compensator the system goes from unstable to
% stable.
% 3) This happens because the controller adds poles/zeros making the system
% reach stablity.
% 4) On adding a Lag Compensator, the rise time is least and settling time
% is highest comparing to the same system in other 2 controllers.
% 5) The Lag Controller, adds a zero and a pole to the system.
% 6) The lag Controller, has a +ve Gm proving its stability.
% 7) The lag controller also has the higest overshoot percentage.
% 8) On adding a Lead Compensator, the rise time and settling time is 
% inbetween comparing to the same system with other 2 controllers.
% 9) The Lead Controller, adds a zero and a pole to the system.
% 10) The lead Controller, has a +ve Gm proving its stability.
% 11) The lead controller provides the minimum overshoot percentage
% compared to the other 2 controllers.
% 12) On adding a Lag-Lead Compensator, the rise time is inbetween and the
% settling time is lowest comparing to the same system in other controllers.
% 13) The Lag-Lead Controller, adds a zero and a pole to the system.
% 14) The Lag-Lead Controller, has a +ve Gm indicating its stability.
% 15) The Lag-Lead Controller provides the second best overshoot percentage
% compared to the other 2 controllers.
% 16) Overall, the lag-lead controller provides the best of all worlds and 
% is the best controller to use. 
