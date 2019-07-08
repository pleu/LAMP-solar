function [output_string] = set_value_from_list(list_values, value)
% set option in option list using either string or integer value
%
%% Syntax
%  value = set_option(list_values, value)
%
%% Input
%  list_values   - Cell Array
%  value         - can be string (only first number of characters need to
%  match) or integer
%
%% Output
%  output_string

  if ischar(value) % set using string
    index = find(strncmpi(value,list_values,length(value)));
    if ~isempty(index)
      output_string = list_values{index};
    else
      error(['The value supplied is not acceptable.  The possibilities are', list_values]);
    end
  elseif find(value == 1:length(list_values)) % set using number
    output_string = list_values{value};
  else
    error('The value supplied is not acceptable');
  end
end

