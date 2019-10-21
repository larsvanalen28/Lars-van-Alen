clear all; close all; clc

[t x1 y1] = textread('veer.txt', '',25);
%x = x1/1000
x = x1*1.02/100;
y = y1*4 ;
P = polyfit(x(1:10),y(1:10),1);
yfit = P(1)*x+P(2);
plot(x,y,'*');
hold all
plot(x, yfit,'');
title('Relation of the force with the deviation');
xlabel('Deviation (m)');
ylabel('Force (N)');
legend({'Measurements','k= N/m'},'Location','northwest','Orientation','vertical')