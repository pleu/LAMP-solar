function [xOut, varargout] = shift_y_value(x, minX, maxX, varargin)
% identifies a transition region and a shift region
% shifts the y values in the shift region up
% shifts the values in the transition to match that at the end of the 
% transition region
% transition region is identified by minX and maxX
% | ----   shift region ----- | ---- transition region-- | final region



numY = nargin - 3;

indOne = find(size(x)== 1);

if size(x, 1) == 1
  x = x';
  for i = 1:numY
    varargin{i} = varargin{i}';
  end
end

[x,ind] = sort(x, 'ascend');
for i = 1:numY
  varargin{i} = varargin{i}(ind);
end

if isempty(find(x <= minX, 1)) || isempty(find(x >= maxX, 1))
  error('remove values cannot be performed; check minX and maxX');
end

xBefore = x(x <= minX);
xAfter = x(x >= maxX);

%xOut = [xAfter; xBefore];
xOut = [xBefore; xAfter];

varargout = cell(numY, 1);
% for i = 1:numY
%   varargout{i} = zeros(length(xOut), 1);
% end

shiftNumbers = 15;
for i = 1:numY
  % find xBefore
  y = varargin{i};
  yBefore = y(x <= minX);
  yAfter = y(x >=maxX);
%   meanBefore = mean(yBefore(1:shiftNumbers));
%   meanAfter = mean(yAfter(end-shiftNumbers:end));
  meanBefore = mean(yBefore(end-shiftNumbers:end));
  meanAfter = mean(yAfter(1:shiftNumbers));
  yAfter = yAfter - (meanAfter - meanBefore);
  %yBefore = yBefore - (meanBefore - meanAfter);
  varargout{i} = [yBefore; yAfter];
end

if size(x, indOne) ~= 1
  xOut = xOut';
  for i = 1:numY
    varargout{i} = varargout{i}';
  end
end
[xOut,ind] = sort(xOut, 'descend');
varargout{i} = varargout{i}(ind);


