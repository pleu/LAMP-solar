function plot_imag_refractive_index_versus_wavelength(obj, varargin)
% PLOT_REFRACTIVE_INDEX_VERSUS_WAVELENGTH 
% Plots the refractive index versus the wavelength for a particular
% material
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  

  
  %figure(figureNumber+1);
  %clf;
  multiplot_add_energy_top_axis({obj.Wavelength},{obj.K},varargin{:});
  %multiplot({obj.Wavelength},{obj.K});
  %title_or_legend({obj.Filename});

  xlabel('Wavelength (nm)');
  ylabel('k');
  
  %grid on;

  
  
end

