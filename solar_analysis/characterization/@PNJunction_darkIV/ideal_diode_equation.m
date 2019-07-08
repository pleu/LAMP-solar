function [y] = ideal_diode_equation(x, xdata)
I0 = x(1);
n = x(2);
kT = 0.026; % in V
y = I0*(exp((xdata)/(kT*n))-1);


