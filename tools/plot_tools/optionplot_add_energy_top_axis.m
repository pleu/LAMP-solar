function p1 = optionplot_add_energy_top_axis(xdata,ydata,varargin)
%MULTIPLOT
% plot ydata against xdata using the options in varargin
%
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh

  p1 = optionplot(xdata,ydata,varargin{:});
  xlabel('Wavelength (nm)');
  %v = axis;
  %axis([v(1) v(2) 0 1]);
  add_energy_top_axis(); 

end

