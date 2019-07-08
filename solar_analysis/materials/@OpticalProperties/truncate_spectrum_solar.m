function obj = truncate_spectrum_solar(obj)
% TRUNCATE_SPECTRUM_WAVELENGTH
% truncates the solar spectrum to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  ss = SolarSpectrum.global_AM1p5();
  obj = obj.truncate_spectrum_wavelength(...
    min(ss.Wavelength), max(ss.Wavelength));
  
end
