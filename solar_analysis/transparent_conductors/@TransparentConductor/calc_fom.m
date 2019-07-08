function [sigmaDCSigmaOP] = calc_fom(sheetResistance, transmission)
%CALC_SHEET_RESISTANCE Summary of this function goes here
%   Detailed explanation goes here

sigmaDCSigmaOP = ...
  Constants.LightConstants.Z0/...
  (2*sheetResistance)*sqrt(transmission)/(1 - sqrt(transmission));

end