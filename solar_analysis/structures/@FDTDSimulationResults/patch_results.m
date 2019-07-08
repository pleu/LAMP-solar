function [sr] = patch_results(sr, filename, independentVariableType, minVariable, maxVariable, variableTruncateType)
% reads in filename
% then range of minVariable to maxVariable


if nargin == 3
  sr.Filename = filename;
  sr.IndependentVariableType = 'Frequency';
elseif nargin == 4
  sr.Filename = filename;
  sr.IndependentVariableType = independentVariableType;
end

sr2 = FDTDSimulationResults(filename, independentVariableType);
sr2 = sr2.truncate(minVariable, maxVariable, variableTruncateType);

[sr.ReflectionResults] = patch_results(sr.ReflectionResults, sr2.ReflectionResults);
[sr.TransmissionResults] = patch_results(sr.TransmissionResults, sr2.TransmissionResults);
[sr.AbsorptionResults] = patch_results(sr.AbsorptionResults, sr2.AbsorptionResults);

%sr = patch_results(sr, sr2);
%sr.TransmissionResults = sr.patch_transmission_results(sr.ReflectionResults.Frequency);
%sr.AbsorptionResults = sr.patch_absorption_results;

end