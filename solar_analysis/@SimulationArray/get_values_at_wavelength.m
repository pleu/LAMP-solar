function [simResults, reflectionData, transmissionData, absorptionData] = get_values_at_wavelength(sa, value)
%GET_VALUES_AT_WAVELENGTH_OR_ENERGY Summary of this function goes here
%   Detailed explanation goes here
simResults = SimulationResults.empty(sa.NumSimulations, 0);
for j= 1:sa.NumSimulations
  ra = [sa.Simulations(j).ReflectionResults];
  ta = [sa.Simulations(j).TransmissionResults];
  %     ta = [sa.Simulations.TransmissionResults];
  %
  reflectionData = interp1(ra.Wavelength, ra.Data, value);
  transmissionData = interp1(ra.Wavelength, ta.Data, value);
  absorptionData = 1 - reflectionData - transmissionData;
  
  simResults(j) = SimulationResults(value, reflectionData, transmissionData, absorptionData);
end

end

