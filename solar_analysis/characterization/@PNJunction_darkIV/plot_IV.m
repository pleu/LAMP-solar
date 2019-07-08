function plot_IV(sc)
% PLOT_IV 
% Plots the current voltage characteristics of the solar cell
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  plot(sc.Voltage,sc.CurrentDark);
  grid on;
  xlabel('Voltage (Volts)');
  ylabel('Current (Amps/m^2)');
end

