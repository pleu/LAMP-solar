function [saAvg] = average_results(sa, sa2)
% will average over varString

%for i = 1:va.NumValues
wavelengths = sa.ReflectionResults.Wavelength;
wavelengths2 = sa2.ReflectionResults.Wavelength;
if ~isequal(wavelengths, wavelengths2)
  warning('The wavelengths between these two variable arrays are different.');
end

dataReflect = (sa.ReflectionResults.Data+sa2.ReflectionResults.Data)/2;
dataTransmit = (sa.TransmissionResults.Data+sa2.TransmissionResults.Data)/2;
dataAbsorb = (sa.AbsorptionResults.Data+sa2.AbsorptionResults.Data)/2;

saAvg = FDTDSimulationResults('');

%simulations = FDTDSimulationResults(wavelengths, dataReflect, dataTransmit, dataAbsorb);

saAvg.ReflectionResults = Monitor('Reflection', sa.ReflectionResults.Frequency, dataReflect);
saAvg.TransmissionResults = Monitor('Transmission', sa.ReflectionResults.Frequency, dataTransmit);
saAvg.AbsorptionResults = Monitor('Absorption', sa.AbsorptionResults.Frequency, dataAbsorb);

% end

%[va2, varIndexOut] = get_sub_variable_array(sa.VariableArray, varString, value);
%saAvg = SimulationArray(va, simulations);

end
