function [sr] = fix_results(sr)

sr.ReflectionResults.Data(sr.ReflectionResults.Data > 1) = 1;
sr.ReflectionResults.Data(sr.ReflectionResults.Data < 0) = 0;

sr.TransmissionResults.Data(sr.TransmissionResults.Data > 1) = 1;
sr.TransmissionResults.Data(sr.TransmissionResults.Data < 0) = 0;

frequency = sr.ReflectionResults.Frequency;
transmission = interp1(sr.TransmissionResults.Frequency,...
  sr.TransmissionResults.Data, frequency, 'linear', 'extrap');
data = 1 - sr.ReflectionResults.Data - transmission;

sr.AbsorptionResults.Frequency = frequency;
sr.AbsorptionResults.Data = data;

