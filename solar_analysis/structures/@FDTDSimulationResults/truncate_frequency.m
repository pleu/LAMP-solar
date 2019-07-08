function obj = truncate_frequency(obj, minFrequency, maxFrequency)
% TRUNCATE_SPECTRUM
% truncates the wavelength to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

for i = 1:size(obj, 2)
  obj(i).ReflectionResults.truncate_frequency(minFrequency, maxFrequency);
  obj(i).TransmissionResults.truncate_frequency(minFrequency, maxFrequency);
  obj(i).AbsorptionResults.truncate_frequency(minFrequency, maxFrequency);
end