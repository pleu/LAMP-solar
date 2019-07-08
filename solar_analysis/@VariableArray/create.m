function va = create(names, units, values)
% creates variables;
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
% va = create_variable_combinations(variablenames, variableUnits
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh
  va = VariableArray(names, units, values);
end