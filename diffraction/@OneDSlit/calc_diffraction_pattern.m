function [diffractionPattern] = calc_diffraction_pattern(obj, wavelength, kx)
%CALC_DIFFRACTION_PATTERN Summary of this function goes here
%   Detailed explanation goes here
% if nargin == 2
%   theta = 0:0.5:90;
% end
%obj.Wavelength = wavelength;
if nargin == 2
  k = 2*pi/wavelength;
  numKPts = 200;
  kx = linspace(-k,k, numKPts);
end

diffractionPattern(length(obj)) =  OneDDiffractionPattern;
for i = 1:length(obj)
  [normalizedIntensity] = obj(i).calc_normalized_intensity(kx);
  diffractionPattern(i) = OneDDiffractionPattern(wavelength, kx, normalizedIntensity);
end

%plot(theta, )


end

