function semilogx_ultimate_efficiency_versus_independent_variable(scArray, varargin)
% PLOT_ULTIMATE_EFFICIENCY_VERSUS_INDEPENDENTVARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  varargin{size(varargin, 2)+1} = 'logarithmicX';
  optionplot(scArray.IndependentVariable, [scArray.SolarCell.UltimateEfficiency], ...
    varargin{:});
  axis([min(scArray.IndependentVariable) max(scArray.IndependentVariable) 0 1]);
  xlabel('Thickness (nm)');
  
  nmToMicron = 1e-3;

  ylabel('Cell Ultimate Efficiency');
end


