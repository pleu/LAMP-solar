function obj = truncate_wavelength(obj, minWavelength, maxWavelength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(obj, 2)
  [obj(i).Wavelength, obj(i).Data] = ...
    truncate(obj(i).Wavelength, minWavelength, maxWavelength, obj(i).Data);
end


