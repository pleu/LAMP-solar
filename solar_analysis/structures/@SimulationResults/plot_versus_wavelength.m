function plot_versus_wavelength(sr, monitorType, varargin)
%PLOT_VERSUS_WAVELENGTH Summary of this function goes here
%   Detailed explanation goes here
  ma = sr.get_monitor(monitorType);
  ma.plot_versus_wavelength(varargin{:});
  title_or_legend({sr.Name});

end
