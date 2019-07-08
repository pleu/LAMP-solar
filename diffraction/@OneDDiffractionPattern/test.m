function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
holeWidth = 50;
wavelength = 500;
theta = -90:0.5:90;
k = 2*pi/wavelength;
kx = k*sin(deg2rad(theta));

normalizedIntensity = (sin(1/2*holeWidth.*kx)./(1/2*holeWidth.*kx)).^2;
normalizedIntensity(kx == 0) = 1;

obj = OneDDiffractionPattern(wavelength, kx, normalizedIntensity);
figure(1);
clf;
obj.plot();


figure(2);
clf;
plot(obj.Kx, obj.NormalizedIntensity);

% x = OneDDiffractionPattern.empty(2, 2, 0);
% x(1, 1) = OneDDiffractionPattern(wavelength, kx, normalizedIntensity);
% x(2, 1) = OneDDiffractionPattern(wavelength, kx, normalizedIntensity);

%obj.calc_haze_angle();


end

