%function analyze_thin_film_results()
%ANALYZE_THIN_FILM_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu

load('InputVariables');
filename = 'SiThinFilmTheta0deg';
sr = FDTDSimulationResults(filename);
%sr.Material = MaterialData(materialName);
ma = MaterialType.create(materialName);
figure(1);
clf;
sr.plot_results_versus_wavelength;

SS = SolarSpectrum.global_AM1p5;
sc = SolarCell(SS, sr, ma);

disp(['Ultimate Efficiency: ', num2str(sc.UltimateEfficiency)]);
