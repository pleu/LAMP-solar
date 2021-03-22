function [varIndex, var, varLabel, varUnits] = get(rb, variable)

if strncmpi(variable, 'latitude', 1)
  varIndex = 1;
  var = rb.Latitudes;
  varLabel = ('Latitude');
  varUnits = ('^{\circ}');
elseif strncmpi(variable, 'beta', 1)
  varIndex = 2;
  var = rb.Betas;
  varLabel = ('Tilt');
  if rb.BetaFractionFlag
    varLabel = ('Tilt');
    varUnits = ('*latitude^{\circ}');
  else
    varUnits = ('^{\circ}');
  end
elseif strncmpi(variable, 'gamma', 1)
  varIndex = 3;
  var = rb.Gammas;
  varLabel = ('Azimuth');
  varUnits = ('^{\circ}');
elseif strncmpi(variable, 'day', 1)
  varIndex = 4;
  var = rb.Days;
  varLabel = ('Day');
  varUnits = ('');
else
  error([variable, ' is not recognized']);
end




