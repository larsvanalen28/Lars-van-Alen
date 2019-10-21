clear all; clc; close all;

%*Determining the timescale*
t_start     = 0        ;
t_end       = 11       ;
n_stamps    = 11001    ; %Amount of  stamps calculated must be atleast 10x t_end

% *Setting the actuator frequency:*
global f_act;
f_start     =  0  ;      
f_end       =  20    ;  
f_stamps    =  201    ; %Amount of stamps the actuator uses can't be more then n_stamps
n=2 ;
% stairs =   (round(linspace(f_start*n,f_end*n,n_stamps)))/n;
% f_act     =   stairs;
f_act = 2;                  % Using a constant frequency for the actuator
[t,phi]=ode45('ODE_v_JJ_5',[linspace(t_start,t_end,n_stamps)],[0;0]);

% * Plotting the movement*
figure
yyaxis left
plot(t,phi(:,1));
title('Actuator (f = ... Hz) on a damped system')
xlabel('Time (s)') 
ylabel('Deviation (m)')
xlim([0 t_end])
%ylim([-0.04 0.06])

% Plotting the frequency of the actuator to the time
% yyaxis right
% plot(t, f_act)
% ylabel('Frequency actuator (Hz)')
% ylim([f_start-0.1 f_end])
% legend('Deviation of the suspension', 'Frequency of the actuator')

% *FFT-diagram*
figure
L = length(phi(:,1));
Fs = 1/((t_end)/L);
Y = fft(phi(:,1));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs * (0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 10])