function plot(sa, xAxis, monitorType)
% monitorType must be 'R', 'T', or 'A'
% use all for all three types
% 
% xAxis should be 'Energy' or 'Wavelength';
% 
%PLOT Summary of this function goes here
%   Detailed explanation goes here
  if strcmpi(xAxis, 'Energy')
    for i = 1:sa.NumSimulations
      if strncmpi(monitorType, 'R', 1)
        sa(i).ReflectionResults.plot_versus_energy;
      elseif strncmpi(monitorType, 'T', 1)
        sa(i).TransmissionResults.plot_versus_energy;
      elseif strncmpi(monitorType, 'A', 1)
        sa(i).AbsorptionResults.plot_versus_energy;
      end
    end
  elseif strcmpi(xAxis, 'Wavelength')
    for i = 1:sa.NumSimulations
      if strncmpi(monitorType, 'R', 1)
        sa(i).ReflectionResults.plot_versus_wavelength;
      elseif strncmpi(monitorType, 'T', 1)
        sa(i).TransmissionResults.plot_versus_wavelength;
      elseif strncmpi(monitorType, 'A', 1)
        sa(i).AbsorptionResults.plot_versus_wavelength;
      end
    end
  else
    error('xAxis must be ''Energy'' or ''Wavelength''');
  end
  
end

