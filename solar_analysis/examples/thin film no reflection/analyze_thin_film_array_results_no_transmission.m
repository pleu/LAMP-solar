%function analyze_thin_film_array_results()
%ANALYZE_THIN_FILM_ARRAY_RESULTS
% Analyzes the results from a several FDTD simulation
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul W. Leu
clear;
ss = SolarSpectrum.global_AM1p5();

load('InputVariables');
%variableValues = Constants.UnitConversions.MtoNM...
%  *linspace(minThickness, maxThickness, numThicknesses)';
variableValues = [60 9960];
variableNames = cellstr(variableStringArray);
variableUnits = cellstr(variableUnitsArray);


va = VariableArray(variableNames, variableUnits, variableValues);
va.create_filenames('SiThinFilm');

sa = FDTDSimulationResultsArray.create(va, 'frequency');


ma = MaterialType.create(materialName);

%sca = SolarCellArray.create(ss, va, ma, 'frequency');
sca = SolarCellArray.create(ss, sa.Simulations, va, ma);
figure(1);
sca.plot_RTA_results_versus_variable(1);

figure(4);
clf;
sca.VariableArray.plot(sca.UltimateEfficiency, 'Ultimate Efficiency');
grid on;

figure(5)
sa.Simulations.plot_results_versus_wavelength(4);

figure(7)
sa.contour('Wavelength', 't', 'Absorption')

%sc.plot_ultimate_efficiency_versus_independent_variable;
