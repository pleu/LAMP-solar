function [frequency] = convert_wavelength_to_frequency(wavelength)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
%
% wavelength is in nm
% 
frequency = Constants.LightConstants.C./wavelength*...
    Constants.UnitConversions.NMperM; 
%./wavelength;
end
