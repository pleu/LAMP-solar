function multiplot_add_wavelength_top_axis(xdata,ydata,varargin)
%MULTIPLOT
% plot ydata against xdata using the options in varargin
%
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  multiplot(xdata,ydata,varargin{:});
  xlabel('Energy (eV)');
  add_wavelength_top_axis();
end
