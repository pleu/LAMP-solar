function obj = truncate_wavelength(obj, minWavelength, maxWavelength)
% TRUNCATE_SPECTRUM
% truncates the wavelength to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

for i = 1:size(obj, 2)
  obj(i).ReflectionResults.truncate_wavelength(minWavelength, maxWavelength);
  obj(i).TransmissionResults.truncate_wavelength(minWavelength, maxWavelength);
  obj(i).AbsorptionResults.truncate_wavelength(minWavelength, maxWavelength);
end