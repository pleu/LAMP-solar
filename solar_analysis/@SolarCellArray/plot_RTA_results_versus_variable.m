function plot_RTA_results_versus_variable(sr, figureNumber, varargin)
%PLOT_RTA_RESULTS_VERSUS_VARIABLE
% Plot integrated reflection, transmission, and absorption versus dependent
% variable
% 
%% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh
  if nargin == 1
    figureNumber = 1;
  end
  
  figure(0 + figureNumber);
  clf;
  sr.VariableArray.plot([sr.SolarCells.ReflectionIntegrated], 'Reflection');
  %grid on;
  
  figure(1 + figureNumber);
  clf;
  sr.VariableArray.plot([sr.SolarCells.TransmissionIntegrated], 'Transmission');
  %grid on;

  
  figure(2 + figureNumber);
  clf;
  sr.VariableArray.plot([sr.SolarCells.AbsorptionIntegrated], 'Absorption');
  %grid on;

end
