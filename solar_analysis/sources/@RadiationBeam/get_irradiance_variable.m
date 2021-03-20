function [varPlot, varMPlot, ylabel] = get_irradiance_variable(rb, variable)

if strncmpi(variable, 'beam', 1)
  varPlot = rb.IbD;
  varMPlot = rb.IbmD;
  ylabel = ('Direct Insolation (kW-h/m^2/day)');
elseif strncmpi(variable, 'diffuse', 3)
  varPlot = rb.IdD;
  varMPlot = rb.IdmD;
  ylabel = ('Diffuse Insolation (kW-h/m^2/day)');
elseif strncmpi(variable, 'total', 1)
  varPlot = rb.ITD;
  varMPlot = rb.ITmD;
  ylabel = ('Total Insolation (kW-h/m^2/day)');
else
  error(variable, ' is not recognized');
end
