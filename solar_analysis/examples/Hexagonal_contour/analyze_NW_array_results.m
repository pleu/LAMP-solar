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

variableStringArray = {'a', 'd'};
variableUnitsArray = {'', ''};
% preallocate variableArray
incrementDiameter = 50e-9;

pitchArray = [100 140 180];
diameterArray = [20 40 60 80 100 120 140 160 180];
variables = {pitchArray, diameterArray};
variables = VariableArray.value_combinations(variables);
variables = variables(variables(:, 2) <= variables(:, 1), :);

va = VariableArray(variableStringArray, variableUnitsArray, variables);
va.create_filenames('SiHexagonalNW', 'Length2330');  

material = MaterialType.create(materialName);

scArray = SolarCellArray.create(ss, va, material, 'frequency');

figure(1);
clf;
scArray.VariableArray.contour('a', 'd', scArray.Absorption) 

figure(2);
clf;
scArray.VariableArray.contour('a', 'd', scArray.UltimateEfficiency) 


