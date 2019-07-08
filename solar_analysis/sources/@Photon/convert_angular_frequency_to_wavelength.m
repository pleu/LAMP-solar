function [wavelength] = convert_angular_frequency_to_wavelength(angular_frequency)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
% angular_frequency is in Hz
% wavelength is in nm

wavelength = 2*pi*Constants.LightConstants.C./angular_frequency *...
    Constants.UnitConversions.NMperM; 
%./wavelength;
end