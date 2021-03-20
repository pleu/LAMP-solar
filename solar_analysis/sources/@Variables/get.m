function [va, ind] = get(obj, name)
%GET_VARIABLE Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(obj)
  if strncmpi(obj(i).Name, name,1)
    ind = i;
    va = obj(i);
  end
end
end

