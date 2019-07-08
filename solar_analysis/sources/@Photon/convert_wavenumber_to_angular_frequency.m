function [angularFrequency] = convert_wavenumber_to_angular_frequency(wavenumber)
%CONVERT_WAVENUMBER_TO_ANGULAR_FREQUENCY Summary of this function goes here
%   Detailed explanation goes here

angularFrequency = Constants.LightConstants.C.*wavenumber.*Constants.UnitConversions.NMperM;

end

