function plot_IV2(sc,varargin)
% PLOT_IV 
% Plots the current voltage characteristics of the solar cell
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

multiplot({sc.Voltage},cellfun(@(x) x/10,{sc.CurrentLight},'un',0),varargin{:});
%plot(sc.Voltage,sc.CurrentLight/10);
grid on;
xlabel('Voltage (Volts)');
ylabel('Current (mA/cm^2)');
end

% A/m^2 * 1000 mA/A * (1/100) (m/cm)^2