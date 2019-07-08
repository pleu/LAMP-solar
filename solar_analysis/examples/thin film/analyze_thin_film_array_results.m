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

va = VariableArray({'t'}, {'nm'}, filmThicknessArray*1e9);
va.create_filenames('SiThinFilm', '');
%variableValues = Constants.UnitConversions.MtoNM...
%  *linspace(minThickness, maxThickness, numThicknesses)';

%sa = FDTDSimulationResultsArray.create(va, 'frequency');
sr = FDTDSimulationResults.create_array(va.Filenames, 'frequency');

ma = MaterialType.create(materialName);

sca = SolarCellArray.create(ss, sr, va, ma);
figure(1);
sca.plot_RTA_results_versus_variable(1);

figure(4);
clf;
sca.VariableArray.plot(sca.UltimateEfficiency, 'Ultimate Efficiency');
grid on;

figure(5)
sr = FDTDSimulationResultsArray.create(va);
sr.FDTDSimulations.plot_results_versus_wavelength(5);

figure(8)
sr.contour('Wavelength', 't', 'Absorption')

%sc.plot_ultimate_efficiency_versus_independent_variable;
