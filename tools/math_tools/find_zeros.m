function [kGuess] = find_zeros(x, y)
% This finds the zeros of a function
% zeros are determined from where the function crosses from negative 
% to positive (or vice versa)
% and where the slope is the same in sign.
if length(x)~=length(y)
  error('Lengths of x and y should be the same');
end
dY = diff(y);
indGuess = intersect(find(y(1:length(y)-1).*y(2:length(y))< 0),find(dY(1:length(dY)-1).*dY(2:length(dY))> 0));
kGuess = x(indGuess);