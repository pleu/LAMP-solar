function [Rs] = calc_sheet_resistance_from_fom(sigmaDCSigmaOP, transmission)
%CALC_SHEET_RESISTANCE Summary of this function goes here
%   Detailed explanation goes here

  Rs = ...
        Constants.LightConstants.Z0/...
        (2*sigmaDCSigmaOP)*sqrt(transmission)/(1 - sqrt(transmission));

end

