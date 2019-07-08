function plot_ultimate_efficiency_versus_thickness(sctfArray)
% PLOT_ULTIMATE_EFFICIENCY_VERSUS_THICKNESS
% Plots efficiency versus thickness
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  nmToMicron = 1e-3;
  semilogx(sctfArray.ThicknessArray*nmToMicron, sctfArray.EfficiencyArray, '-x');
  axis([min(thicknessArray*nmToMicron) max(thicknessArray*nmToMicron) 0 1]);
  xlabel('Thickness (\mum)');
  ylabel('Cell Efficiency');
end


