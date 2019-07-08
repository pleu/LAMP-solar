%ANALYZE_TRANSPARENT_CONDUCTOR_ARRAY_RESULTS
% Analyzes the results from a several FDTD simulation
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2012
% Paul W. Leu

clear;
hold on;

materialName = 'Si';
ss = SolarSpectrum.global_AM1p5;

pitchArray = [100 140 180];
diameterArray = [20 40 60 80 100 120 140 160 180];
variables = {pitchArray};
%variables = VariableArray.value_combinations(variables);
%variables = variables(variables(:, 2) <= variables(:, 1), :);

va = VariableArray('a', '', pitchArray);
va.create_filenames('SiHexagonalNW','d20Length2330');

sa = FDTDSimulationResultsArray.create(va, 'frequency');

figure(3);
clf;

sa.contour('a', 'Wavelength', 'Absorption')

figure(4)
clf;
sa.contour('a', 'Energy', 'Absorption')


