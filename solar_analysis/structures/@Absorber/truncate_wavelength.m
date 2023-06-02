function [obj] = truncate_wavelength(obj, minWavelength, maxWavelength)
%TRUNCATE_ENERGY Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(obj, 2)
  obj(i).ReflectionResults.truncate_wavelength(minWavelength, maxWavelength);
  obj(i).TransmissionResults.truncate_wavelength(minWavelength, maxWavelength);
  obj(i).AbsorptionResults.truncate_wavelength(minWavelength, maxWavelength);
end

