function semilogx_limiting_eff_detailed_versus_independent_variable(scArray, ...
  varargin)
% PLOT_ULTIMATE_EFFICIENCY_VERSUS_INDEPENDENTVARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  varargin{size(varargin, 2)+1} = 'logarithmicX';
  optionplot(scArray.IndependentVariable, [scArray.SolarCell.LimitingEfficiencyDetailed], ...
  varargin{:});
  axis([min(scArray.IndependentVariable) max([scArray.IndependentVariable]) 0 1]);
  xlabel(scArray.IndependentVariableLabel);
  ylabel('Cell Limiting Efficiency Detailed');
end


