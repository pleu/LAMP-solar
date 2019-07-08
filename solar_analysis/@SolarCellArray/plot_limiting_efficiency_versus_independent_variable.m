function plot_limiting_efficiency_versus_independent_variable(scArray)
% PLOT_LIMITING_EFFICIENCY_VERSUS_INDEPENDENT_VARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  plot(scArray.IndependentVariable, [scArray.SolarCell.LimitingEfficiency], '-');
  axis([min(scArray.IndependentVariable) max(scArray.IndependentVariable) 0 1]);
  xlabel(scArray.IndependentVariableLabel);
  ylabel('Cell Limiting Efficiency');
end


