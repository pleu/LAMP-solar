function [saAvg] = average_simulation_array(sa, sa2)
% will average over varString

% check to make sure variable arrays are identical
%if %~isequal(sa.VariableArray, sa2.VariableArray)
if ~isequal(sa.VariableArray.Values, sa2.VariableArray.Values)
  warning('The variable arrays between these two simulations are different.');
end

%va = sa.VariableArray; 
va = VariableArray(sa.VariableArray.Names, sa.VariableArray.Units, sa.VariableArray.Values);

simulations = SimulationResults.empty(va.NumValues, 0);

for i = 1:va.NumValues
  wavelengths = sa.Simulations(i).ReflectionResults.Wavelength;
  wavelengths2 = sa2.Simulations(i).ReflectionResults.Wavelength;
  if ~isequal(wavelengths, wavelengths2)
    warning('The wavelengths between these two variable arrays are different.');
  end

  dataReflect = (sa.Simulations(i).ReflectionResults.Data+sa2.Simulations(i).ReflectionResults.Data)/2;
  dataTransmit = (sa.Simulations(i).TransmissionResults.Data+sa2.Simulations(i).TransmissionResults.Data)/2;
  dataAbsorb = (sa.Simulations(i).AbsorptionResults.Data+sa2.Simulations(i).AbsorptionResults.Data)/2;
 
  simulations(i) = SimulationResults(wavelengths, dataReflect, dataTransmit, dataAbsorb);
  % end
end

%[va2, varIndexOut] = get_sub_variable_array(sa.VariableArray, varString, value);
saAvg = SimulationArray(va, simulations);

end

