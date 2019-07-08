function obj = truncate_spectrum_visible(obj)
% TRUNCATE_SPECTRUM
% truncates the solar spectrum to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  obj = obj.truncate_spectrum_wavelength(390, 750);
  % visible wavelength range is from 390 to 750 nm
end
