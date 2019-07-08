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

variableStringArray = {'dTop', 'dBot'};
variableUnitsArray = {'', ''};
% preallocate variableArray
%incrementDiameter = 50e-9;

dTopArray = [40 80 120];
dBotArray = [40 80 120];


materialName = 'Si';
ss = SolarSpectrum.global_AM1p5;

variables = {dTopArray};
%variables = VariableArray.value_combinations(variables);
%variables = variables(variables(:, 2) <= variables(:, 1), :);

va = VariableArray('dTop', '', dTopArray);
va.create_filenames('SiNC','dBot80');

sa = FDTDSimulationResultsArray.create(va, 'frequency');

figure(3);
clf;

sa.contour('dTop', 'Wavelength', 'Absorption')

figure(4)
clf;
sa.contour('dTop', 'Energy', 'Absorption')


