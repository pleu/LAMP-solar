function [obj] = truncate_wavelength(obj, minWavelength, maxWavelength)
%TRUNCATE_WAVELENGTH Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(obj.SolarCells, 2)
  obj.SolarCells(i).truncate_wavelength(minWavelength, maxWavelength);
end



