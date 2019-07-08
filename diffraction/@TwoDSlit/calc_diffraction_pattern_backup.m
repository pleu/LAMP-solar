function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength, kx)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here
k = 2*pi/wavelength;

if nargin == 2 
%   [theta,phi] = meshgrid(linspace(0,2*pi,361),linspace(0,90,91));
%   [kxGrid,kyGrid,kzGrid] = sph2cart(theta,phi,k);
  

  [phi,theta] = meshgrid(0:pi/30:(pi/2),0:pi/30:(2*pi));
  kxGrid = k*sin(phi).*cos(theta);
  kyGrid = k*sin(phi).*sin(theta);
  %z = phi - theta;
  
%  thetaCheck = atan(kyGrid./kxGrid);
%  phiCheck = acos(sqrt(1 - (kxGrid/k).^2 - (kyGrid/k).^2));

  
  %kx = unique(kxGrid)';
  %ky = unique(kyGrid)';
end
%thetaX = rad2deg(asin(kx/k));
%thetaY = rad2deg(asin(ky/k));

normalizedIntensityX = obj.OneDSlitX.calc_normalized_intensity(kxGrid); 
normalizedIntensityY = obj.OneDSlitY.calc_normalized_intensity(kyGrid); 

normalizedIntensity = normalizedIntensityY.*normalizedIntensityX;

diffractionPattern = TwoDDiffractionPattern(wavelength, kxGrid, kyGrid, normalizedIntensity, 'trapz');



end

