function plot_IV(sc)
% PLOT_IV 
% Plots the current voltage characteristics of the solar cell
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  AXIS_LIMITS_SCALE = 1.3; % multiplier for y-axis 
  plot(sc.Voltage,sc.CurrentSC-sc.CurrentDark);
  axis([0 sc.Structure.MaterialData.BandGap -AXIS_LIMITS_SCALE*sc.CurrentSC ...
    AXIS_LIMITS_SCALE*sc.CurrentSC]);
  grid on;
  xlabel('Voltage (Volts)');
  ylabel('Current (Amps/m^2)');
end


