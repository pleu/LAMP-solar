function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here

[kxGrid, kyGrid, kroneckerDelta, deltaInd] = obj.create_kGrid(wavelength);
[kPointsNewMat] = obj.create_kPointsNewMat(kxGrid, kyGrid);

dp = obj.TwoDSlit.calc_diffraction_pattern(wavelength, kxGrid, kyGrid);

normalizedIntensitySingle = dp.NormalizedIntensity;


[normalizedIntensity] = obj.modify_normalized_intensity_array(normalizedIntensitySingle, kPointsNewMat, kroneckerDelta, deltaInd);



if isinf(obj.Number(1))
  diffractionPattern = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'sum');
else
  diffractionPattern = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');  
end
indNotCenter = diffractionPattern.Phi ~= 0;
%indCenter = obj.Phi == 0;
numDeltas = sum(diffractionPattern.NormalizedIntensity(indNotCenter)~=0)








end

