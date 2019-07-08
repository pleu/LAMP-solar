function plot_at_value(sa, value, xAxis, monitorType)
%PLOT_AT_VALUE 
% monitorType must be 'R', 'T', or 'A'
% use all for all three types
% value is variable value
% 
% xAxis should be 'Energy' or 'Wavelength';
% 
  %ind = find();
  FDTDresults = sa.FDTDSimulations(sa.VariableArray.Values == value);
  if strcmpi(xAxis, 'Energy')
    FDTDresults.plot_versus_energy(monitorType);
  elseif strcmpi(xAxis, 'Wavelength')
    FDTDresults.plot_versus_wavelength(monitorType);
  else
    error('xAxis must be ''Energy'' or ''Wavelength''');
  end
end

