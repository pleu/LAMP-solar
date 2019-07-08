function [xOut, varargout] = keep_values(x, minX, maxX, varargin)
% TRUNCATE
%
% keeps values of x between range minX and maxX
%
% See also
%
% Examples
%
% Copyright 2018
% Paul Leu
% LAMP, University of Pittsburgh


numY = nargin - 3;

indOne = find(size(x)== 1);

if size(x, 1) == 1
  x = x';
  for i = 1:numY
    varargin{i} = varargin{i}';
  end
end

ind = find(x >= minX & x <= maxX);
if isempty(ind)
  error('remove values cannot be performed; check minX and maxX');
end
xOut = x(ind);
varargout = cell(numY, 1);
for i = 1:numY
  varargout{i} = zeros(length(ind), 1);
end
for i = 1:numY
  varargout{i} = varargin{i}(ind);
end

if isempty(find(x == minX, 1))
  if x(1) < x(length(x))
    xOut = [minX; xOut];
    %xOut(2:end+1) = xOut;
    %xOut(1) = minX;
    for i = 1:numY
      varargout{i} = [interp1(x, varargin{i}, minX); varargout{i}];
    end
  else
    %xOut(end+1) = minX;
    xOut = [xOut; minX];
    for i = 1:numY
      varargout{i} = [varargout{i}; interp1(x, varargin{i}, minX)];
    end
  end
end
if isempty(find(x == maxX, 1))
  if x(1) < x(length(x))
    xOut = [xOut; maxX];
    for i = 1:numY
      varargout{i} = [varargout{i}; interp1(x, varargin{i}, maxX)];
    end
  else
    xOut = [maxX; xOut];
    for i = 1:numY
      varargout{i} = [interp1(x, varargin{i}, maxX); varargout{i}];
    end
  end
end

if size(x, indOne) ~= 1
  xOut = xOut';
  for i = 1:numY
    varargout{i} = varargout{i}';
  end
end

%   if isempty(find(x == minX, 1))
%     xOut = [minX; xOut];
%     for i = 1:numY
%       varargout{i} = [interp1(x, varargin{i}, minX); varargout{i}];
%     end
%   end
%   if isempty(find(x == maxX, 1))
%     xOut = [xOut; maxX];
%     varargout{i} = [varargout{i}; interp1(x, varargin{i}, maxX)];
%   end


end