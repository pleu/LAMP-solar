function plot_irradiance_versus_energy(obj)
% PLOT_IRRADIANCE_VERSUS_ENERGY
% Plots the solar spectrum irradiance as function of photon 
% energy
% 
% See also PLOT_IRRADIANCE_VERSUS_WAVELENGTH
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  multiplot_add_wavelength_top_axis({obj.Energy}, {obj.IrradianceEnergy})
  title_or_legend({obj.Name});

  xlabel('Energy (eV)');
  ylabel('Spectral Irradiance (W*m^{-2}eV^{-1})');
  grid on;
end