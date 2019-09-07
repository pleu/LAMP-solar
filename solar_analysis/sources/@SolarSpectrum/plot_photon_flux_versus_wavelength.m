function plot_photon_flux_versus_energy(obj)
% PLOT_IRRADIANCE_VERSUS_ENERGY
% Plots the solar spectrum irradiance as function of photon 
% energy
% 
% See also PLOT_IRRADIANCE_VERSUS_WAVELENGTH
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  multiplot_add_wavelength_top_axis({obj.Wavelength}, {obj.PhotonFlux/1e21;})
  title_or_legend({obj.Name});

  xlabel('Wavelength (nm)');
  ylabel('Photon Flux (10^{21} photons*m^{-2}eV^{-1})');
  %grid on;
end