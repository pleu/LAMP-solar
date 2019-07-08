function [frequency] = convert_wavenumber_to_frequency(wavenumber)
%CONVERT_WAVENUMBER_TO_ANGULAR_FREQUENCY Summary of this function goes here
%   Detailed explanation goes here

frequency = Constants.LightConstants.C.*wavenumber.*Constants.UnitConversions.NMperM./(2*pi);

end

