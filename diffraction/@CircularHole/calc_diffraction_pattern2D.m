function [diffractionPattern] = calc_diffraction_pattern2D(obj, wavelength, theta)
%CALC_DIFFRACTION_PATTERN2D Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
  theta = 0:0.5:90;
end

k = 2*pi/wavelength;

%zeros of spherical bessel function
numZeros = floor(k*obj.Diameter/pi);
bZeros = zeros(numZeros, 1);
bessj0 = @(x) besselj(1,x);
for n = 1:numZeros
  bZeros(n) = fzero(bessj0,[(n-1) n]*pi);
end
theta1 = rad2deg(asin(bZeros./(k*obj.Diameter)));
theta = unique([theta theta1']);

normalizedIntensity = (2*besselj(1,k*obj.Diameter.*sin(deg2rad(theta)))./...
  (k*obj.Diameter.*sin(deg2rad(theta)))).^2;
normalizedIntensity(theta == 0) = 1;

diffractionPattern = OneDDiffractionPattern(wavelength, theta, normalizedIntensity, 'trapzSpherical');

end

