function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength, kxGrid, kyGrid)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here
k = 2*pi/wavelength;

if nargin == 2   
  [theta,phi] = meshgrid(linspace(0,2*pi,361),linspace(0,pi/2,181));
  [kxGrid,kyGrid] = pol2cart(theta,k*sin(phi));
end

normalizedIntensityX = obj.OneDSlitX.calc_normalized_intensity(kxGrid); 
normalizedIntensityY = obj.OneDSlitY.calc_normalized_intensity(kyGrid); 
normalizedIntensity = normalizedIntensityY.*normalizedIntensityX;

diffractionPattern = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');



end

