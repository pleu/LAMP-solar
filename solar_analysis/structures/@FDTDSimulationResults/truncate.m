function [sr] = truncate(sr, minValue, maxValue, valueType)
%TRUNCATE Summary of this function goes here
%   Detailed explanation goes here

if strcmp(valueType, 'Frequency')
  sr.truncate_frequency(minValue, maxValue);
elseif strcmp(valueType, 'Wavelength')
  sr.truncate_wavelength(minValue, maxValue);
elseif strcmp(valueType, 'Energy')
  sr.truncate_energy(minValue, maxValue);
end


end

