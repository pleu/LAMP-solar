function va = create_variable_combinations(names, units, values)
% creates all possible combinations of variables;
% variables should be cell array
% for example
% 
% Input
% variablenames - cell of variablenames
% variableunits - cell of variable 
% 
% variablenames = {'dtop', 'dbot'};
% variableUnitsArray = {'nm', 'nm'};
% variableArray2 = {[10 20],[20 30]};
% va = VariableArray.create_variable_combinations(variablenames, variableUnitsArray, variableArray2)
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh
  
  if size(values, 2)~=size(names, 2) && size(values, 2)~= ...
    size(units, 2)
      error('values must be same size as variables and units');
  end
  va = VariableArray(names, units, VariableArray.value_combinations(values));
end


