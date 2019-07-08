function loglog_refractive_index_versus_wavelength(obj, figureNumber)
% LOGLOG_REFRACTIVE_INDEX_VERSUS_LOG_WAVELENGTH 
% Plots the refractive index versus the wavelength for a particular
% material on a loglog scale
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  if nargin == 1
    figureNumber = 1;
  end

  figure(figureNumber);
  clf;
  multiplot({obj.Wavelength},{obj.N}, 'loglog');
  xlabel('Wavelength (nm)');
  ylabel('n');
  title_or_legend({obj.Filename});
  grid on;
  
  figure(figureNumber+1);
  clf;
  multiplot({obj.Wavelength},{obj.K}, 'loglog');
  title_or_legend({obj.Filename});

  xlabel('Wavelength (nm)');
  ylabel('k');
  
  grid on;
end


