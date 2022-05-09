function [sa] = symmetry90(sa, varIndex)
%MIRROR This assumes 0 is at the 0 position
if max(sa.VariableArray.Values(:, varIndex)) ~= 90
  error('The maximum value in the variable array is not 90 degrees');
end
numSims = length(sa.Simulations);
sa.Simulations = sa.Simulations(numSims:-1:1);

varTheta = setdiff(1:sa.VariableArray.NumVariables, varIndex);

sa.VariableArray.Values(:, varTheta) = sa.VariableArray.Values(numSims:-1:1,varTheta);
varIndMirror = sa.VariableArray.Values(:, varIndex)~=0;
sa.VariableArray.Values = [sa.VariableArray.Values; sa.VariableArray.Values(varIndMirror,:)];
sa.Simulations = [sa.Simulations sa.Simulations(varIndMirror)];
sa.VariableArray.Values(1:numSims,varIndex) = -sa.VariableArray.Values(1:numSims,varIndex);
sa.VariableArray.Values(:, varIndex) = sa.VariableArray.Values(:, varIndex) + 90;

% replicate once;
varIndReplicate = sa.VariableArray.Values(:, varIndex)~=0;

indexIncrement = [180];
%varReplicate = sa.VariableArray.Values;

for i = 1:length(indexIncrement)
  valuesAdd = sa.VariableArray.Values(varIndReplicate,:);
  valuesAdd(:,varIndex) = valuesAdd(:,varIndex)+indexIncrement(i);
  sa.VariableArray.Values = [sa.VariableArray.Values; valuesAdd];
  sa.Simulations = [sa.Simulations sa.Simulations(varIndReplicate)];
end

[B, index] = sortrows(sa.VariableArray.Values,[1:sa.VariableArray.NumVariables]);
sa.VariableArray.Values = B;
sa.Simulations = sa.Simulations(index);

end

%460*2 = 920
% should be 46 * 19 = 874