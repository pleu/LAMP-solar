function [sa] = mirror(sa)
%MIRROR Summary of this function goes here
%   Detailed explanation goes here

numSims = length(sa.Simulations);
sa.Simulations = sa.Simulations(numSims:-1:1);
sa.Simulations(numSims+1:2*numSims-1) = sa.Simulations(numSims-1:-1:1);

sa.VariableArray.Values = -sa.VariableArray.Values(numSims:-1:1);
sa.VariableArray.Values(numSims+1:2*numSims-1) = -sa.VariableArray.Values(numSims-1:-1:1);

end

