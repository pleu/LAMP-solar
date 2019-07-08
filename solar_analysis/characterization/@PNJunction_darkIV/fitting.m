%function [] = fitting
clear;
IV = load('IV2.txt');
microntoA = 1e-3;
I = IV(:,3)*microntoA;
V = IV(:,2);
linearVoltage_min = 1.1;
linearVoltage_max = 3; % voltage above which is approximately linear
plot(V, I, 'ro');
title('I-V');
%index = find(~isnan(I)==1 & V < linearVoltage)
%indexV = find(V > 3);
index = find(V > linearVoltage_max);
P = polyfit(I(index), V(index), 1);
R = P(1);
%R = (V(index)-V(index-1))/(I(index)-I(index-1));

%F = @(x, xdata)x(1)*exp((xdata - I*R)/(0.026*x(2)));
options = optimoptions(@lsqcurvefit, 'Algorithm', 'levenberg-marquardt','MaxIter', 10000,'MaxFunEvals',10000, 'TolFun', 1e-9);
%F = @(x, xdata)0.026*x(3)*log(xdata/x(1)) + x(2)*xdata; 
F = @(x, xdata)ideal_diode_equation(x, xdata);
I0guess = -I(1);
x0 = [I0guess 30]
lb = [];
ub = [];
Ifit = ideal_diode_equation(x0, V-I*R);
%Ifit2 = ideal_diode_equation(x0, V-Ifit*R);
hold on;
plot(V, Ifit, 'b-');

[x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,V,I,lb,ub,options)
%[x] = lsqcurvefit(F,x0,V,I,lb,ub,options)

%Ifit3 = ideal_diode_equation(x, V-I*R);
hold on
plot(V,F(x,V),'black-');
%plot(V, Ifit3, 'c-');
hold off

% plot(I, V, 'ro');
% options = optimoptions(@lsqcurvefit, 'Algorithm', 'levenberg-marquardt','MaxIter', 10000,'MaxFunEvals',10000, 'TolFun', 1e-9);
% F = @(x, xdata)0.026*x(3)*log(xdata/x(1)) + x(2)*xdata; 
% x0 = [0.009 90 1.5];
% lb = [];
% ub = [];
% [x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,I,V,lb,ub,options);
% 
% hold on
% plot(I,F(x,I))
% hold off