% Structure reconciliation with a template
function [T,S] = structrecon(S,D)

% Check arguments, must have two structures
if ~(isstruct(S) && isstruct(D))
   error('input arguments must be structures');
end
   
T     = D;             % copy the template
fname = fields(T);     % make a list of field names

% Loop over all fields in the template, copy matching values from S
for k = 1:length(fname)
   % Process matching field names in S
   if isfield(S,fname{k})
      % Is this a substructure ?
      if isstruct(T.(fname{k})) && isstruct(S.(fname{k}))
         % Recursively process the substructure
         T.(fname{k}) = structrecon(S.(fname{k}),T.(fname{k}));
      % Not a substructure, copy field value from S
      else T.(fname{k}) = S.(fname{k});
      end
      S = rmfield(S,fname{k});
   end
end
end
