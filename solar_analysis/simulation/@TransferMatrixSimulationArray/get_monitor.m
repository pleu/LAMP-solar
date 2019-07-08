function [monitor, monitorType] = get_monitor(sa, monitorType)

monitor = Monitor.empty(length(sa.TransferMatrixSimulations),0);
if strncmpi(monitorType, 'TEr', 3)
  monitor = [sa.FDTDSimulations.ReflectionResults];
  monitorType = 'Reflection';
elseif strncmpi(monitorType, 'TET', 3)
  monitor = [sa.FDTDSimulations.TransmissionResults];
  monitorType = 'Transmission';
elseif strncmpi(monitorType, 'TEA', 3)
  for i = 1:length(sa.TransferMatrixSimulations)
    monitor(i) = [sa.TransferMatrixSimulations(i).SimulationResultsTE.AbsorptionResults];
  end
  monitorType = 'Absorption';
elseif strncmpi(monitorType, 'TMr', 3)
  monitor = [sa.FDTDSimulations.ReflectionResults];
  monitorType = 'Reflection';
elseif strncmpi(monitorType, 'TMT', 3)
  monitor = [sa.FDTDSimulations.TransmissionResults];
  monitorType = 'Transmission';
elseif strncmpi(monitorType, 'TMA', 3)
  for i = 1:length(sa.TransferMatrixSimulations)
    monitor(i) = [sa.TransferMatrixSimulations(i).SimulationResultsTM.AbsorptionResults];
  end
  monitorType = 'Absorption';
else
  error('monitor type not recognized');
end

end

