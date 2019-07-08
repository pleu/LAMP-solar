function [] = plot_diffraction_pattern(obj, wavelength)
%DIFFRACTION Summary of this function goes here
%   Detailed explanation goes here

%maxK = 2*pi/wavelength;
%k = 2*pi/wavelength;
%theta = linspace(-90,90);
%[theta, normalizedIntensity] = calc_diffraction_pattern(obj, wavelength);

plot(theta, normalizedIntensity);
%plot(theta, (sin(1/2*k*obj.HoleWidth.*sin(theta/180*pi))./(1/2*k*obj.HoleWidth.*sin(theta/180*pi))).^2)

axis([-90 90 0 1]);

end

