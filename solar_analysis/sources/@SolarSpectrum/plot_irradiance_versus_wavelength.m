function plot_irradiance_versus_wavelength(obj)
% PLOT_IRRADIANCE_VERSUS_WAVELENGTH
% plots the solar spectrum irradiance as function of wavelength 
% 
% See also PLOT_IRRADIANCE_VERSUS_ENERGY
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

  multiplot_add_energy_top_axis({obj.Wavelength}, {obj.Irradiance})
  title_or_legend({obj.Name}); 
  xlabel('Wavelength (nm)');
  ylabel('Spectral Irradiance (W*m^{-2}nm^{-1})');
  %grid on;
  
end

