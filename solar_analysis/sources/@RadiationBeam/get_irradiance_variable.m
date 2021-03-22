function [varPlot, varMPlot, varLabel, dorA] = get_irradiance_variable(rb, variable)

if strncmpi(variable, 'beamDay', 5)
  varPlot = rb.IbD;
  varMPlot = rb.IbmD;
  varLabel = ('Direct Insolation (kW-h/m^2/day)');
  dorA = 'd';
elseif strncmpi(variable, 'diffuseDay', 8)
  varPlot = rb.IdD;
  varMPlot = rb.IdmD;
  varLabel = ('Diffuse Insolation (kW-h/m^2/day)');
  dorA = 'd';
elseif strncmpi(variable, 'totalDay', 6)
  varPlot = rb.ITD;
  varMPlot = rb.ITmD;
  varLabel = ('Total Insolation (kW-h/m^2/day)');
  dorA = 'd';
elseif strncmpi(variable, 'beamAnnual', 5)
  varPlot = rb.IbA;
  varMPlot = rb.IbmA;
  varLabel = ('Direct Insolation (kW-h/m^2)');
  dorA = 'A';
elseif strncmpi(variable, 'diffuseAnnual', 8)
  varPlot = rb.IdD;
  varMPlot = rb.IdmD;
  varLabel = ('Diffuse Insolation (kW-h/m^2)');
  dorA = 'A';
elseif strncmpi(variable, 'totalAnnual', 6)
  varPlot = rb.ITA;
  varMPlot = rb.ITmA;
  varLabel = ('Total Insolation (kW-h/m^2)');
  dorA = 'A';
else
  error([variable, ' is not recognized']);
end


