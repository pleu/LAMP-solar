function reflectionResults = calc_reflection_results(sr)
file = dir([sr.Filename, 'R*']);
filename = file.name;
[frequency, data] = ...
  sr.read_monitor_results(filename, ...
  sr.IndependentVariableType);
reflectionResults = Monitor('Reflection', frequency, data);
end