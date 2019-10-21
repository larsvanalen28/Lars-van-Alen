% Note that in the experiment file you can not clear all, or variables from
% compare.m will be lost.

% List of good looking graphs = [2 2.5] Hz (They look especially good if
% you zom in on xlim([0 5]).
formatSpec = '%s%s%s';
fileID = fopen('2Hz.txt');
A = textscan(fileID,formatSpec, 10000);

% Replace all commas with decimal points
decimal_strings_t = regexprep(A{1}, ',', '.');
decimal_strings_y = regexprep(A{3}, ',', '.');

% Convert to doubles and join all rows together
t = cellfun(@str2num, decimal_strings_t, 'uni', 0);
t = cat(1, t{:});

% Convert to doubles and join all rows together
y1 = cellfun(@str2num, decimal_strings_y, 'uni', 0);
y1 = cat(1, y1{:});

y2 = -(y1*1.02/100);
y = y2-mean(y2);

plot(t, y);
xlim([0 5])
title('Experiment');
xlabel('Time(s)');
ylabel('Deviation (m)');

figure
L = 10000;
Fs = 1000;

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
%xlim([0 10])