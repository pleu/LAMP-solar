function variableNamesOut = str2cell(variableNames)
  if ~iscell(variableNames)
    variableNamesOut = {variableNames};
  else
    variableNamesOut = variableNames;
  end
end

