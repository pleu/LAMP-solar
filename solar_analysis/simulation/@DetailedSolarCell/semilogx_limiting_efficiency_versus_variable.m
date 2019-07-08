function semilogx_limiting_efficiency_versus_variable(scArray, varargin)
% PLOT_ULTIMATE_EFFICIENCY_VERSUS_INDEPENDENT_VARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  varargin{size(varargin, 2)+1} = 'logarithmicX';
  optionplot(scArray.IndependentVariable, [scArray.SolarCell.LimitingEfficiency], ...
    varargin{:});
  axis([min(scArray.IndependentVariable) max(scArray.IndependentVariable) 0 1]);
  xlabel(scArray.IndependentVariableLabel);
  ylabel('Cell Limiting Efficiency');
end


