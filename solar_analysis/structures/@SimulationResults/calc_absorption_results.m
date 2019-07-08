function [absorptionResults] = calc_absorption_results(sr)
% This is written in case frequencies are different
frequency = sr.ReflectionResults.Frequency;
if length(frequency) > 1
  transmission = interp1(sr.TransmissionResults.Frequency,...
    sr.TransmissionResults.Data, frequency, 'linear', 'extrap');
else
  transmission = sr.TransmissionResults.Data;
end
data = 1 - sr.ReflectionResults.Data - transmission;
absorptionResults = Monitor('Absorption', frequency, data);
end
