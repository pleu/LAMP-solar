function obj = pick_spectrum_wavelength(obj, wavelength)
% TRUNCATE_SPECTRUM
% picks single wavelength out of the solar spectrum 
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  for i = 1:size(obj, 2)
    obj(i).Irradiance = interp1(obj(i).Wavelength, obj(i).Irradiance, wavelength);
    obj(i).Wavelength = wavelength;
  end