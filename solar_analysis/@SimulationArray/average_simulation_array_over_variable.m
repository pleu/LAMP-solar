function [sa2] = average_simulation_array_over_variable(sa, varString)
% will average over varString

[va2] = get_sub_variable_array(sa.VariableArray, varString); 

%varIndexOut

indexC = strfind(sa.VariableArray.Names,va2.Names);
%indexVar = find(not(cellfun('isempty',indexC)));
simulations = SimulationResults.empty(va2.NumValues, 0);
for i = 1:va2.NumValues
  curValue = va2.Values(i);
  indexIntegrate = find(sa.VariableArray.Values(:,not(cellfun('isempty',indexC))) == curValue);
  wavelengths = sa.Simulations(i).ReflectionResults.Wavelength;
  numWavelengths = length(wavelengths);
  numSims = length(indexIntegrate);
  dataReflect = zeros(numSims, numWavelengths);
  dataTransmit = zeros(numSims, numWavelengths);
  dataAbsorb = zeros(numSims, numWavelengths);
  weights = ones(numSims, 1);
  weights(1) = 1/2;
  weights(end) = 1/2;
  
  for j= 1:length(indexIntegrate)
    dataReflect(j,:) = sa.Simulations(indexIntegrate(j)).ReflectionResults.Data;
    dataTransmit(j,:) = sa.Simulations(indexIntegrate(j)).TransmissionResults.Data;
    dataAbsorb(j,:) = sa.Simulations(indexIntegrate(j)).AbsorptionResults.Data;
  end
  
  reflectionData = mean(weights.*dataReflect, 1);
  transmissionData = mean(weights.*dataTransmit, 1);
  absorptionData = mean(weights.*dataAbsorb, 1);
  simulations(i) = SimulationResults(wavelengths, reflectionData, transmissionData, absorptionData);
  % end
end

%[va2, varIndexOut] = get_sub_variable_array(sa.VariableArray, varString, value);
sa2 = SimulationArray(va2, simulations);

end

