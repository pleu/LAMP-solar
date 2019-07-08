function [index] = get_index_from_list(list_values, value)    
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
  index = find(strncmpi(value,list_values,length(value)));
end

