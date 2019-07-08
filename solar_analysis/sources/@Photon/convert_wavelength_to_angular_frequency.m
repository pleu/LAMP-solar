function [angular_frequency] = convert_wavelength_to_angular_frequency(wavelength)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
% wavelength is in nm
% angular_frequency is in Hz
angular_frequency = 2*pi*Constants.LightConstants.C./wavelength*...
    Constants.UnitConversions.NMperM; 
%./wavelength;
end
