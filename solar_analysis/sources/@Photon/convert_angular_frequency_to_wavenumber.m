function [wavenumber] = convert_angular_frequency_to_wavenumber(angularFrequency)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
% angular_frequency is in Hz
% wavenumber is in 1/nm

wavenumber = angularFrequency/Constants.LightConstants.C/Constants.UnitConversions.NMperM;

end