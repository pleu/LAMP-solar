% Convert a structure to an argument pairs cell array
function P = struct2pv(S)

% Check input argument
if ~isstruct(S), P = {}; return; end

% Get field names
n = fieldnames(S);

% Convert structure values to cell array
v = struct2cell(S);

% Combine names and values, return a 1xN cell array
P = {n{:}; v{:}};
P = P(:).';
end
