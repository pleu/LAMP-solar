function plot_log_alpha_versus_energy(obj)
% PLOT_LOG_ALPHA_VERSUS_ENERGY 
% Plots the log of the absorption coefficient versus the energy for a 
% particular material
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  multiplot_add_wavelength_top_axis({obj.Energy}, {obj.Alpha}, 'logarithmic');
  title_or_legend({obj.Filename});  
  xlabel('Energy (eV)');
  ylabel('Absorption Coefficient (1/nm)');
  grid on;
  
  
end