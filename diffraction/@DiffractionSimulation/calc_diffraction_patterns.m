function [obj] = calc_diffraction_patterns(obj)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here
if strcmp(obj.Structure.Symmetry, '1D')
  obj.DiffractionPattern = OneDDiffractionPattern.empty(obj.LightSource.NumWavelength, 0);
end

for i = 1:obj.LightSource.NumWavelength
  obj.DiffractionPattern(i) = obj.Structure.calc_diffraction_pattern(obj.LightSource.Wavelength(i));
end

