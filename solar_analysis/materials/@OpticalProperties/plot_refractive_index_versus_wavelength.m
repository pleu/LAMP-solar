function plot_refractive_index_versus_wavelength(obj, varargin)
% PLOT_REFRACTIVE_INDEX_VERSUS_WAVELENGTH 
% Plots the refractive index versus the wavelength for a particular
% material
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  %figure(figureNumber);
  %clf;
  if size(obj) == 1
    optionplot_add_energy_top_axis(obj.Wavelength, obj.N, varargin{:});
  else
    multiplot_add_energy_top_axis({obj.Wavelength},{obj.N},varargin{:});
  end
  %multiplot({obj.Wavelength},{obj.N});
  xlabel('Wavelength (nm)');
  ylabel('n');
  %title_or_legend({obj.Filename});
  %grid on;
  
  
  %grid on;

  
  
end

