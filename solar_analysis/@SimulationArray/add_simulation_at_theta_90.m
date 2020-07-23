function [sa] = add_simulation_at_theta_90(sa, value)

va = sa.VariableArray;
varIndex = va.get_variable_ind('Phi');

uniquePhi = unique(va.Values(:, varIndex));

if varIndex == 2
  varAdd = [90*ones(length(uniquePhi), 1), uniquePhi];
  va.Values = [va.Values; varAdd];
  va.create_filenames('', '');
else
  
end

if nargin == 1
  if isa(sa.Simulations, 'FDTDSimulationResults')
    sr = FDTDSimulationResults.empty(length(uniquePhi), 0);
    for i = 1:length(uniquePhi)
      sr(i) = FDTDSimulationResults.create_empty_simulation_results(sa.Simulations(1).ReflectionResults.Wavelength);
    end
  else
    sr = SimulationResults.empty(length(uniquePhi), 0);
    for i = 1:length(uniquePhi)
      sr(i) = SimulationResults.create_empty_simulation_results(sa.Simulations(1).ReflectionResults.Wavelength);
    end
  end
else
  if isa(sa.Simulations, 'FDTDSimulationResults')
    sr = FDTDSimulationResults.empty(length(uniquePhi), 0);
    for i = 1:length(uniquePhi)
      sr(i) = FDTDSimulationResults.create_empty_simulation_results(sa.Simulations(1).ReflectionResults.Wavelength);
    end
  else
    sr = SimulationResults.empty(length(uniquePhi), 0);
    for i = 1:length(uniquePhi)
      sr(i) = SimulationResults.create_empty_simulation_results(sa.Simulations(1).ReflectionResults.Wavelength);
    end
  end
end

sa.Simulations = [sa.Simulations sr];


end

