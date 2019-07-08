function [obj] = plot_alpha_versus_wavelength(obj)
% READ_OPTICAL_PROPERTIES 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

  multiplot({obj.Wavelength}, {obj.Alpha});
  title_or_legend({obj.Filename}); 
  
  xlabel('Wavelength (nm)');
  ylabel('Absorption Coefficient (1/nm)');
  grid on;

end