function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here

diffractionPattern(size(obj, 1), size(obj,2)) = TwoDDiffractionPattern;

for i = 1:size(obj, 1)
  for j = 1:size(obj, 2)
    [kxGrid, kyGrid, kroneckerDelta, deltaInd] = obj(i,j).create_kGrid(wavelength);
    [kPointsNewMat] = obj(i,j).create_kPointsNewMat(kxGrid, kyGrid);
    
    dp = obj(i,j).CircularHole.calc_diffraction_pattern(wavelength, kxGrid, kyGrid);
    normalizedIntensitySingle = dp.NormalizedIntensity;
    
    
    [normalizedIntensity] = obj(i,j).modify_normalized_intensity_array(normalizedIntensitySingle, kPointsNewMat, kroneckerDelta, deltaInd);
    if isinf(obj(i,j).Number(1))
      diffractionPattern(i,j) = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'sum');
      %diffractionPattern(i,j) = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');
    else
      diffractionPattern(i,j) = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');
    end
  end
end