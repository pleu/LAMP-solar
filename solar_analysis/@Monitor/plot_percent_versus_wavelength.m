function plot_percent_versus_wavelength(obj,varargin)
% PLOT_VERSUS_WAVELENGTH 
% Plots monitor data versus wavelength
% 
% See also PLOT_VERSUS_ENERGY
%
%% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
if size(obj) == 1
  optionplot_add_energy_top_axis(obj.Wavelength,obj.Data*100,varargin{:});
else
  multiplot_add_energy_top_axis({obj.Wavelength},{obj.Data*100},varargin{:});
end
  %xlabel('Wavelength (nm)');
  ylabel([obj(1).Type,'']);
%  grid on;
  axis([280 max(obj(1).Wavelength) 0 100]);

%  add_energy_top_axis(energyTicks, energyLabels);  

  
end