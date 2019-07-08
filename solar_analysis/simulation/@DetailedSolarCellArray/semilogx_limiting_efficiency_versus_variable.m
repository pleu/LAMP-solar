function semilogx_limiting_efficiency_versus_variable(scArray, varString, varargin)
% PLOT_LIMITING_EFFICIENCY_VERSUS_INDEPENDENTVARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  varargin{size(varargin, 2)+1} = 'logarithmicX';
  x = scArray.VariableArray.get_variable_values(varString);
  optionplot(x, [scArray.SolarCells.LimitingEfficiency], ...
    varargin{:});
  axis([min(x) max(x) 0 1]);
  xlabel(scArray.VariableArray.get_variable_axislabel(varString));
  
  ylabel('Cell Limiting Efficiency');
end

