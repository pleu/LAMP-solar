function plot_IV(sc,varargin)
% PLOT_IV 
% Plots the current voltage characteristics of the solar cell
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
multiplot({sc.Voltage},{sc.CurrentLight},varargin{:});
grid on;
xlabel('Voltage (Volts)');
ylabel('Current (Amps/m^2)');
end

