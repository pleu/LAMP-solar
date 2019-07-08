function [valueCombinations] = value_combinations(variableArray)
%VALUE_COMBINATIONS
%  
% variableArray = {[10 20],[20 30]};
% value_combinations(variableArray);
% output = [10 20;
%         10 30;
%         20 20;
%         20 30];
% 
% 
  if ~iscell(variableArray) 
    error('values must be cell array');
  end
  valueCombinations = allcomb(variableArray{:});

end

