function [va2, varIndexOut] = get_sub_variable_array(va, varString, value)
% creates variableArray where varString == value

if nargin == 3
  varIndex = va.get_variable_ind(varString);
  varIndexNot = setdiff(1:va.NumVariables, va.get_variable_ind(varString));
  varIndexOut = find(va.Values(:, varIndex) == value);
  va2 = VariableArray(va.Names(varIndexNot), va.Units(varIndexNot),... 
    va.Values(varIndexOut, varIndexNot));
  va2.Filenames = va.Filenames(varIndexOut);
else
  varIndex = va.get_variable_ind(varString);
  varIndexNot = setdiff(1:va.NumVariables, va.get_variable_ind(varString));
  
  
  uniqueValuesKeep = unique(va.Values(:, varIndexNot));
  uniqueValuesEliminate = unique(va.Values(:, varIndex));
  
  
  
  % check that all values covered
  if size(va.Values(:, varIndex), 1) ~= length(uniqueValuesKeep)*length(uniqueValuesEliminate)
    warning(['Every value may not be contained when collapsing along', varString]);
  end
  % 
  varIndexOut = find(va.Values(:, varIndex) == uniqueValuesEliminate(1));
  
  % check to make sure can collapse along that dimension
  
  va2 = VariableArray(va.Names(varIndexNot), va.Units(varIndexNot),... 
    va.Values(varIndexOut, varIndexNot));
end
