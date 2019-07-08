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

numContourLines = 200;
materialName = 'Si';
ss = SolarSpectrum.global_AM1p5;

variableStringArray = {'dTop', 'dBot'};
variableUnitsArray = {'', ''};
% preallocate variableArray
%incrementDiameter = 50e-9;

dTopArray = [40 80 120];
dBotArray = [40 80 120];
variables = {dTopArray, dBotArray};
variables = VariableArray.value_combinations(variables);
%variables = variables(variables(:, 2) <= variables(:, 1), :);

va = VariableArray(variableStringArray, variableUnitsArray, variables);
va.create_filenames('SiNC', '');  

material = MaterialType.create(materialName);

scArray = SolarCellArray.create_FDTD(ss, va, material, 'frequency');

figure(1);
clf;
va.contour('dBot', 'dTop', scArray.Absorption, numContourLines) 

figure(2);
clf;
va.contour('dBot', 'dTop', scArray.UltimateEfficiency, numContourLines) 


