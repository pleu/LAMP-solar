function [x] = set_range(x, xMin, xMax, warning)
%SET_RANGE 
% sets any values that are below xMin to xMin and any values that are 
% above xMax to xMax
% Warning = 1 will display a warning if something below xMin or 
% above xMax is reached

x(x < xMin) = xMin;
x(x > xMax) = xMax;

end

