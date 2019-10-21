function dphidt = ODE(t,phi)
global f_act      % Frequency of the actuator [Hz]
% vector phi consists out of two elements:
% element phi(1) is the position y
% element phi(2) is the velocity v (in the y-direction)
% vector dphidt has to consist out of two elements as well:
% element dphidt(1) is de derivative dy/dt, which is the velocity (phi(2))
% element dphidt(2) is de derivative dv/dt, which is the acceleration
k = 48.9 ; % Stiffness factor   [N/m]
x_dif = 2.44e-2;  % Disposition of the suspenion when putting it on its side [m]

g = 9.81;  % Gravity acceleration      [m/s^2]

mu = 4*pi * 10^-7;% Permeability of space     [Tm/A]
r_eq = 6 * 10^-2; % Distance between magnetic poles, top -and bottom magnet, at equilibrium [m]
Q = k*x_dif*(r_eq + x_dif)^4 * 2*pi/(3*mu) ;  % Product of magnetic dipoles [J^2]

m = 3 * mu / (2*pi) * Q * 1/(r_eq^4) / g ;    % Mass of the suspension    [kg] 
d = 2*m*0.1644 ;  % Damping factor     [Ns/m]

% f_cur = f_act(int64(round(t,2)*100 + 1));% Using a single value in chronological order for the f_act matrix per time step to compute the actuator amplitude.
f_cur = f_act;      % Using a constant frequency for the actuator
% act = -9.556e-04 * cos(2 * pi * f_cur * t);    % Amplitude of the bottom magnet [m]

a1 =   0.0004877;
b1 =12.58 ;
c1 =      0.5321 ;
a2 =   0.0004433 ;
b2 =25.15 ;
c2 =      -1.176  ;
a3 =    0.000261  ;
b3 =37.76;
c3 =2.918  ;
a4 =   0.0001771 ;
b4 =50.36 ;
c4 =     -0.0544  ;
a5 =   1.027e-05  ;
b5 =26.98 ;
c5 =      -4.637  ;
a6 =   1.824e-05  ;
b6 =51.94 ;
c6 =      -3.087  ;
a7 =   2.191e-05 ;
b7 =37.51 ;
c7 =6.414 ;
a8 =   1.598e-05;
b8 =12.45;
c8 =3.438;

act = a1*sin(f_cur*b1*t+c1) + a2*sin(f_cur*b2*t+c2) + a3*sin(f_cur*b3*t+c3) + a4*sin(f_cur*b4*t+c4) + a5*sin(f_cur*b5*t+c5) + a6*sin(f_cur*b6*t+c6) + a7*sin(f_cur*b7*t+c7) + a8*sin(f_cur*b8*t+c8);   % Amplitude of the bottom magnet [m]
r = r_eq + phi(1) + act;   % Distance between magnetic poles [m]
k

dphidt=zeros(2,1); % Defining a 2 collumn vector dpidt(t)
dphidt(1)= phi(2); % The derivative of the position, dphidt(1), equals the velocity, phi(2)
dphidt(2)= -g - k/m * phi(1) - d/m * phi(2) + 3 * mu / (2*pi*m) * Q * 1/(r^4); % The acceleration expressed in the rest of the orces at play