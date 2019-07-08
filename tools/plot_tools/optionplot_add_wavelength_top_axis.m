function optionplot_add_wavelength_top_axis(xdata,ydata,varargin)
%MULTIPLOT
% plot ydata against xdata using the options in varargin
%
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh

  optionplot(xdata,ydata,varargin{:});
  xlabel('Energy (eV)');
  %v = axis;
  %axis([v(1) v(2) 0 1]);
  add_wavelength_top_axis(); 

end

