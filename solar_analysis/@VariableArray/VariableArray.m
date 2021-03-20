classdef VariableArray < handle
%VARIABLEARRAY
% 
% VARIABLEARRAY(variableNames, variableUnits, values) creates variable 
% array from variableNames, variableUnits, and vlues
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh  
  properties
    Names;        % different variables
    Units;        % same size as variable names
    Values;       % actual numbers of variables used; 
    Filenames;    % each row is a separate file; all the names in each column
                  % will be averaged together
  end
  
  
  properties(Dependent)
    NumValues;
    NumVariables;
    VariableStrings; 
    VariableAxisLabels;
  end
  
  methods

    %     function [ind] = get_values_condition(va, condition)
    %       ind = va.VariableAxisLabels(va.get_variable_ind(name));
    %       in
    %     end
    function va = VariableArray(variableNames, variableUnits, values)
      va.Names = str2cell(variableNames);
      va.Units = str2cell(variableUnits);
      va.Values = values;
      va = va.error_check();
      va.Filenames = va.VariableStrings;
    end
      
    
    function [values] = get_variable_axislabel(va, name)
      values = va.VariableAxisLabels(va.get_variable_ind(name));
    end

    
    function [values] = get_variable_values(va, name)
      % gives all the values for variable with 'name'
      % result = va.find_variable('pitch')
      % result = [10 20 30];
      indVariable = va.get_variable_ind(name); 
      values = va.Values(:, indVariable);
    end
    
    function [indVariable] = get_variable_ind(va, name)
      indVariable = find(strcmpi(char(name), va.Names)==1);
      if isempty(indVariable)
        error(['Could not find', name, 'in variableArray']);
      end
    end
    
    function check_if_variable(va, name)
      %indVariable = ;
      if isempty(find(strcmpi(char(name), va.Names)==1,1))
        error(['Could not find', name, 'in variableArray']);
      end
    end
    
    
    function numVariables = get.NumVariables(va)
      numVariables = length(va.Names);
    end
    
    function numValues = get.NumValues(va)
      numValues = size(va.Values,1);
    end
    
    function variableStrings = get.VariableStrings(va)
      variableStrings = cell(va.NumValues, 1);
      for i = 1:va.NumValues
        for j = 1:va.NumVariables
            variableStrings{i} = [variableStrings{i}, va.Names{j},...
            num2str(va.Values(i,j)), va.Units{j}]; 
        end 
      end
    end
    
    function variableAxisLabels = get.VariableAxisLabels(va)
      variableAxisLabels = cell(va.NumVariables, 1);
      for i = 1:va.NumVariables
        variableAxisLabels{i} = [va.Names{i}, ' (', va.Units{i}, ')']; 
      end
    end
    
    function va = error_check(va)
      if all(size(va.Names)~=size(va.Units))
        error('names and units must be the same length');
      end
      if size(va.Values, 2)~=size(va.Units, 2)
        if size(va.Values, 1)==size(va.Units, 2)
          va.Values = va.Values';
        end
      end
%       if isnumeric(va.Values)
%         va.Values = num2cell(va.Values);
%       end
    end
  end
    

  
  methods(Access = protected)
     
  end
  
  methods(Static)
    test()

    va = create_variable_combinations(names, units, values);
    
    valueCombinations = value_combinations(values);
    
    valueCombinations = value_combinations_less_than(values);
    
  end
  
end

