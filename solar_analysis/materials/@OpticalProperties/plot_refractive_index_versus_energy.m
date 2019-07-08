function plot_refractive_index_versus_energy(obj, figureNumber)
% PLOT_REFRACTIVE_INDEX_VERSUS_ENERGY 
% Plots the refractive index versus the energy for a particular material
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  if nargin == 1
    figureNumber = 1;
  end

  figure(figureNumber);
  clf;
  multiplot_add_wavelength_top_axis({obj.Energy}, {obj.N}, 'logarithmic');

  %multiplot({obj.Energy},{obj.N});
  xlabel('Energy (eV)');
  ylabel('n');
  title_or_legend({obj.Filename});
  grid on;
  
  figure(figureNumber+1);
  clf;
  %multiplot({obj.Energy},{obj.K});
  multiplot_add_wavelength_top_axis({obj.Energy}, {obj.K}, 'logarithmic');
  title_or_legend({obj.Filename});

  xlabel('Energy (eV)');
  ylabel('k');
  
  grid on;
end