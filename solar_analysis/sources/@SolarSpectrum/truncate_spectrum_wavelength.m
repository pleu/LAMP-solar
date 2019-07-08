function obj = truncate_spectrum_wavelength(obj, minWavelength, maxWavelength)
% TRUNCATE_SPECTRUM
% truncates the solar spectrum to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

disp(['Warning: When you truncate the solar spectrum, the integrated absorption,', ...
  'reflection, and transmission are only shown over the truncated range.']);


for i = 1:size(obj, 2)
  [obj(i).Wavelength, obj(i).Irradiance] = ...
    truncate(obj(i).Wavelength, minWavelength, maxWavelength, obj(i).Irradiance);
end