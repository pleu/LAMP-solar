function [ energy ] = convert_wavenumber_to_energy(wavenumber)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
%   Detailed explanation goes here

wavelength = 2*pi./wavenumber;
energy = Constants.LightConstants.HC./wavelength;

end
