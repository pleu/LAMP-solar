function plot_versus_energy(obj,varargin)
% PLOT_VERSUS_ENERGY 
% Plots monitor data versus photon energy
% 
% See also PLOT_VERSUS_WAVELENGTH
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
if size(obj) == 1
  optionplot_add_wavelength_top_axis(obj.Energy,obj.Data,varargin{:});
else
  multiplot_add_wavelength_top_axis({obj.Energy},{obj.Data},varargin{:});
end
  xlabel('Energy (eV)');
  ylabel([obj.Type]);
  %grid on;
  axis([0 max([obj.Energy]) 0 1]);
  %title_or_legend({obj.Name});
  
  %add_wavelength_top_axis(wavelengthTicks, wavelengthLabels);  

end
