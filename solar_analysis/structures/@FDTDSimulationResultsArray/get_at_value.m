function [FDTDresults] = get_at_value(sa, value)
%GET_AT_VALUE Summary of this function goes here
%   Detailed explanation goes here
  FDTDresults = sa.FDTDSimulations(sa.VariableArray.Values == value);
end

