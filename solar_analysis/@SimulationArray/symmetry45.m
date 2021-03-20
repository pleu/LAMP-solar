function [sa] = symmetry45(sa, varIndex)
%MIRROR This assumes 0 is at the 0 position
if max(sa.VariableArray.Values(:, varIndex)) ~= 45
  error('The maximum value in the variable array is not 45 degrees');
end
numSims = length(sa.Simulations);
sa.Simulations = sa.Simulations(numSims:-1:1);

sa.VariableArray.Values = sa.VariableArray.Values(numSims:-1:1,:);
varIndMirror = sa.VariableArray.Values(:, varIndex)~=0;
sa.VariableArray.Values = [sa.VariableArray.Values; sa.VariableArray.Values(varIndMirror,:)];
sa.Simulations = [sa.Simulations sa.Simulations(varIndMirror)];
sa.VariableArray.Values(1:numSims,varIndex) = -sa.VariableArray.Values(1:numSims,varIndex);
sa.VariableArray.Values(:, varIndex) = sa.VariableArray.Values(:, varIndex) + 45;

% replicate three times;
varIndReplicate = sa.VariableArray.Values(:, varIndex)~=0;
indexIncrement = [90 180 270];
%varReplicate = sa.VariableArray.Values;

for i = 1:length(indexIncrement)
  valuesAdd = sa.VariableArray.Values(varIndReplicate,:);
  valuesAdd(:,varIndex) = valuesAdd(:,varIndex)+indexIncrement(i);
  sa.VariableArray.Values = [sa.VariableArray.Values; valuesAdd];
  sa.Simulations = [sa.Simulations sa.Simulations(varIndReplicate)];
end

[B, index] = sortrows(sa.VariableArray.Values,[1 2]);
sa.VariableArray.Values = B;
sa.Simulations = sa.Simulations(index);

end

%460*2 = 920
% should be 46 * 19 = 874