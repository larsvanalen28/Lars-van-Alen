% Note that in the experiment file you can not clear all, or variables from
% compare.m will be lost.

% List of good looking graphs = [2 2.5] Hz (They look especially good if
% you zom in on xlim([0 5]).

% Use element 5 up to and including element 14
formatSpec = '%{HH:mm:ss.SSS}D %f%f';
fileID = fopen('Amplitude_Bottom_Magnet_1hz.txt');
A = textscan(fileID,formatSpec, 401, 'HeaderLines',1);
t1 = A{1};
y1 = A{3};
t = second(t1) - second(t1(1));
for i = 2:length(t)
    if t(i) < t(1)
        t(i) = t(i) + 60;
    end
end
y2 = -(y1*1.02/100);
y = y2-mean(y2);

plot(t, y);
xlim([0 5])
title('Amplitude actuator');
xlabel('Time(s)');
ylabel('Deviation (m)');

figure
L = 145;
Fs = 20;

Y = fft(y);
P2_1 = abs(Y/L);
P1_1 = P2_1(1:L/2+1);
P1_1(2:end-1) = 2*P1_1(2:end-1);

f = Fs * (0:(L/2))/L;

plot(f,P1_1)
hold on
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 10])

t_fit = t(5:144);
y_fit = y(5:144);

load census
cftool