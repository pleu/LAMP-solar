function [ wavenumber ] = convert_frequency_to_wavenumber(frequency)
%CONVERT_WAVELENGTH_TO_WAVENUMBER Summary of this function goes here
% 
% frequency is in Hz (1/sec)
% wavenumber is in (1/nm)

wavenumber = 2*pi*frequency./(Constants.LightConstants.C.*Constants.UnitConversions.NMperM);



end

