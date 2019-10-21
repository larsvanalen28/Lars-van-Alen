clear all; clc; close all;

% Running the code from the model example file: 'RunningODE_example.m'
RunningODE_v_JJ_5;
close all;
% Saving the data from 'RunningODE_example.m'
start = 435;
t_mod = t(1+start:10000+start);         %   In seconds
t_mod = t_mod - t_mod(1);
y_mod = phi(1+start:10000+start,1) ;  %   Deviation in m

clearvars -except t_mod y_mod

% Running the code from the experiment file: 'Experiment.m'
Experiment;
close all;
% Saving the data from 'Experiment.m'
t_exp = t;         %   In seconds
y_exp = y;         %   Deviation in m

clearvars -except t_exp y_exp t_mod y_mod

% Plotting the two movements against each other. Note that t_mod and t_exp don't
% need to have the same dimension, but they should start at t = 0 and end
% at the same value, e.g. t = 60.
plot(t_mod, y_mod)
hold on
plot(t_exp, y_exp)
%title('Deviation of the setup for f_{act} = 4 Hz')
xlabel('t (s)')
legend('Model','Experiment')
ylabel('y (m)')
xlim([0 5])
% ylim([-0.01 0.01])

% Calculating the root mean square error between the two datasets. This
% can only be calculated when y_mod and y_exp have the same length and if all
% elements of y_exp are nonzero.
% The returned value p is the root mean square percentage error between
% lists y_mod and y_exp.
if size(y_mod) == size(y_exp) & not(ismember(0, y_exp))
    p_pos = errperf(y_exp, y_mod, 'mape'); % Calculate percentage error between deviation
end

% *FFT-diagram*
figure
L = 10000;
Fs = 1000;

y_mod = fft(y_mod);
P2_1 = abs(y_mod/L);
P1_1 = P2_1(1:L/2+1);
P1_1(2:end-1) = 2*P1_1(2:end-1);

y_exp = fft(y_exp);
P2_2 = abs(y_exp/L);
P1_2 = P2_2(1:L/2+1);
P1_2(2:end-1) = 2*P1_2(2:end-1);

f = Fs * (0:(L/2))/L;

plot(f,P1_1)
hold on
plot(f,P1_2)
%title('FFT-diagram for f_{act} = 4 Hz')
xlabel('f (Hz)')
ylabel('|P1(f)|')
legend('Model','Experiment')
xlim([0 10])
