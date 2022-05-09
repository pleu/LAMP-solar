function [sa] = symmetry360(sa)
%MIRROR This assumes 0 is at the 0 position
numSims = length(sa.Simulations);

theta = sa.VariableArray.Values;
phi = 0:2:360;
numPhi = length(phi);
variableArray = {theta,phi};
[valueCombinations] = VariableArray.value_combinations(variableArray);
%[valueCombinations] = value_combinations(variableArray);
%sa.VariableArray
vaNew = VariableArray({'Theta', 'Phi'}, {'Deg', 'Deg'}, valueCombinations);
%vaNew = VariableArray(variableNames, variableUnits, values)

simulationsNew = SimulationResults.empty(vaNew.NumValues, 0);
for i = 1:length(theta)
  for j = 1:numPhi
    simulationsNew((i-1)*numPhi+j) = sa.Simulations(i);
  end
end

sa.VariableArray = vaNew;
sa.Simulations = simulationsNew;

%sa.VariableArray = vaNew;



%sa.Simulations = sa.Simulations(numSims:-1:1);
%varTheta = setdiff(1:sa.VariableArray.NumVariables, varIndex);

% replicate around phi

%varIndReplicate = sa.VariableArray.Values(:, varIndex)~=0;
%indexIncrement = [90 180 270];
%varReplicate = sa.VariableArray.Values;


end

%460*2 = 920
% should be 46 * 19 = 874