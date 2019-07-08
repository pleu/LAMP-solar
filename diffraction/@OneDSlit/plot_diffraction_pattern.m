function [] = plot_diffraction_pattern(obj, wavelength)
%DIFFRACTION Summary of this function goes here
%   Detailed explanation goes here

%maxK = 2*pi/wavelength;
[obj] = obj.calc_diffraction_pattern(wavelength);
obj.DiffractionPattern.plot();

end

