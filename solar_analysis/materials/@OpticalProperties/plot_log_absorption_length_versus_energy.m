function plot_log_absorption_length_versus_energy(obj)
% PLOT_LOG_ABSORPTION_LENGTH_VERSUS_ENERGY 
% Plots the log of the absorption LENGTH versus the energy for a 
% particular material
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  multiplot_add_wavelength_top_axis({obj.Energy}, {obj.AbsorptionLength}, 'logarithmic')
  title_or_legend({obj.Filename});
  
  xlabel('Energy (eV)');
  ylabel('Absorption Length (nm)');
  grid on;
  
end
