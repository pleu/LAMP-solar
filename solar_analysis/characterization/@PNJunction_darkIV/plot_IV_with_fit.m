function plot_IV_with_fit(sc)
% PLOT_IV 
% Plots the current voltage characteristics of the solar cell
%
% Copyright 2011
% Paul Leu, Brad Pafchek
% LAMP, University of Pittsburgh

plot(sc.Voltage, sc.CurrentDark, 'ro', sc.VoltageFit, sc.CurrentFit, 'b-');

title('Diode IV Curve')
xlabel('Voltage (V)')
ylabel('Current (A)')



end

