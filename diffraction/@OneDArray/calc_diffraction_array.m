function [diffractionPattern] = calc_diffraction_array(obj,dp,wavelength, k1)
%CALC_DIFFRACTION_ARRAY 
% Takes normalized intensity for single instance and multiplies 
% by factors for periodic array in 1D

%k = 2*pi/wavelength;
normalizedIntensitySlit = dp.NormalizedIntensity;
theta = dp.Theta;
kx = dp.Kx;

%k = (obj.Pitch/(2*pi))*kx;

if isinf(obj.Number)
  kroneckerDelta = zeros(1, numel(theta));
  kroneckerDelta(ismember(kx, k1)) = 1;
  %kroneckerDelta(ismember(theta, theta1)) = 1;
  normalizedIntensity = normalizedIntensitySlit.*kroneckerDelta;
  normalizedIntensity(kx == 0) = 1;
  %diffractionPattern = OneDDiffractionPattern(wavelength, kx, normalizedIntensity, 'sum');
  %diffractionPattern = OneDDiffractionPattern(wavelength, kx, normalizedIntensity, 'trapz');
else  
  normalizedIntensity = normalizedIntensitySlit.*...
    (sin(obj.Number*1/2*kx*obj.Pitch)./...
    (sin(1/2*obj.Pitch.*kx))).^2/obj.Number^2;
  normalizedIntensity(ismember(kx, k1)) = normalizedIntensitySlit(ismember(kx, k1));
  
%   normalizedIntensity = normalizedIntensitySlit.*...
%     (sin(obj.Number*1/2*k*obj.Pitch.*sin(deg2rad(theta)))./...
%     (sin(1/2*k*obj.Pitch.*sin(deg2rad(theta))))).^2/obj.Number^2;
%   normalizedIntensity(ismember(theta, theta1)) = (sin(1/2*k*obj.HoleWidth.*sin(deg2rad(theta1)))./...
%     (1/2*k*obj.HoleWidth.*sin(deg2rad(theta1)))).^2;
  normalizedIntensity(kx == 0) = 1;
 
  %diffractionPattern = OneDDiffractionPattern(wavelength, kx, normalizedIntensity, 'trapz');
end
diffractionPattern = OneDDiffractionPattern(wavelength, kx, normalizedIntensity, 'trapz');


end

