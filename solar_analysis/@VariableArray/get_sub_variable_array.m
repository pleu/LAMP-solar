function [va2, varIndexOut] = get_sub_variable_array(va, varString, value)
% creates variableArray where varString == value
  varIndex = va.get_variable_ind(varString);
  varIndexNot = setdiff(1:va.NumVariables, va.get_variable_ind(varString));
  varIndexOut = find(va.Values(:, varIndex) == value);
  va2 = VariableArray(va.Names(varIndexNot), va.Units(varIndexNot),... 
    va.Values(varIndexOut, varIndexNot));
  va2.Filenames = va.Filenames(varIndexOut);
end
