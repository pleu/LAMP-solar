function plot_ultimate_efficiency_versus_independent_variable(scArray,varargin)
% PLOT_ULTIMATE_EFFICIENCY_VERSUS_INDEPENDENTVARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  xAxisLabel = [char(scArray.VariableArray.Names), ' (',...
    char(scArray.VariableArray.Units), ')'];

  optionplot(scArray.VariableArray.Values, [scArray.UltimateEfficiency],...
    varargin{:});
  axis([min(scArray.VariableArray.Values) max(scArray.VariableArray.Values) 0 1]);
  xlabel(xAxisLabel);
  ylabel('Ultimate Efficiency');
end


