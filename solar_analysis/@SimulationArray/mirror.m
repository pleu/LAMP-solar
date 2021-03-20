function [sa] = mirror(sa, valuePosition)
%MIRROR This assumes 0 is at the 0 position

if nargin == 0
  numSims = length(sa.Simulations);
  sa.Simulations = sa.Simulations(numSims:-1:1);
  sa.Simulations(numSims+1:2*numSims-1) = sa.Simulations(numSims-1:-1:1);
  
  sa.VariableArray.Values = -sa.VariableArray.Values(numSims:-1:1);
  sa.VariableArray.Values(numSims+1:2*numSims-1) = -sa.VariableArray.Values(numSims-1:-1:1);
else
  numSims = length(sa.Simulations);
  sa.Simulations = sa.Simulations(numSims:-1:1);
  sa.Simulations(numSims+1:2*numSims-1) = sa.Simulations(numSims-1:-1:1);

  sa.VariableArray.Values = sa.VariableArray.Values(numSims:-1:1);
  sa.VariableArray.Values = -sa.VariableArray.Values(numSims:-1:1);
  sa.VariableArray.Values(numSims+1:2*numSims-1) = -sa.VariableArray.Values(numSims-1:-1:1);
end

