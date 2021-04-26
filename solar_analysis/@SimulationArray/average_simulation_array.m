function [saAvg] = average_simulation_array(sa, sa2)
% will average over varString

% check to make sure variable arrays are identical
%if %~isequal(sa.VariableArray, sa2.VariableArray)
if length(sa) ~= length(sa2)
  error('The two simulation arrays must have the same size');
end

saAvg = SimulationArray.empty(length(sa), 0);

for ind = 1:length(sa)
  if ~isequal(sa(ind).VariableArray.Values, sa2(ind).VariableArray.Values)
    warning('The variable arrays between these two simulations are different.');
  end
  
  %va = sa.VariableArray;
  va = VariableArray(sa(ind).VariableArray.Names, sa(ind).VariableArray.Units, sa(ind).VariableArray.Values);
  
  simulations = SimulationResults.empty(va.NumValues, 0);
  
  for i = 1:va.NumValues
    wavelengths = sa(ind).Simulations(i).ReflectionResults.Wavelength;
    wavelengths2 = sa2(ind).Simulations(i).ReflectionResults.Wavelength;
    if ~isequal(wavelengths, wavelengths2)
      warning('The wavelengths between these two variable arrays are different.');
    end
    
    dataReflect = (sa(ind).Simulations(i).ReflectionResults.Data+sa2(ind).Simulations(i).ReflectionResults.Data)/2;
    dataTransmit = (sa(ind).Simulations(i).TransmissionResults.Data+sa2(ind).Simulations(i).TransmissionResults.Data)/2;
    dataAbsorb = (sa(ind).Simulations(i).AbsorptionResults.Data+sa2(ind).Simulations(i).AbsorptionResults.Data)/2;
    
    simulations(i) = SimulationResults(wavelengths, dataReflect, dataTransmit, dataAbsorb);
    % end
  end
  
  %[va2, varIndexOut] = get_sub_variable_array(sa.VariableArray, varString, value);
  saAvg(ind) = SimulationArray(va, simulations);
end

end

