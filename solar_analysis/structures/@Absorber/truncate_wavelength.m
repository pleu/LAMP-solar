function [obj] = truncate_wavelength(obj, minWavelength, maxWavelength)
%TRUNCATE_ENERGY Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(obj, 2)
  obj(i).AbsorptionResults.truncate_wavelength(minWavelength, maxWavelength);
end

