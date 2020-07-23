function [absorptionResults] = calc_absorption_results(sr, percent)
% This is written in case frequencies are different
if nargin == 1
  percent = 0;
end
frequency = sr.ReflectionResults.Frequency;
if length(frequency) > 1
  transmission = interp1(sr.TransmissionResults.Frequency,...
    sr.TransmissionResults.Data, frequency, 'linear', 'extrap');
else
  transmission = sr.TransmissionResults.Data;
end
if percent
  data = 100 - sr.ReflectionResults.Data - transmission;
else
  data = 1 - sr.ReflectionResults.Data - transmission;
end
absorptionResults = Monitor('Absorption', frequency, data);
end
