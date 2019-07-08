% function analyze_thin_film_results()
%ANALYZE_THIN_FILM_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

load('InputVariables');
filename = 'SiThinFilmt400nm';
sr = FDTDSimulationResults(filename);
ma = MaterialType.create(materialName);

figure(1);
clf;
sr.plot_results_versus_energy;
%sr.plot_results_versus_wavelength;
%set(gcf, 'Position', [800 500 540 390])

SS = SolarSpectrum.global_AM1p5();
%SS = SS.truncate_spectrum_visible;
sc = SolarCell(SS, sr, ma);

disp(['Ultimate Efficiency: ', num2str(sc.UltimateEfficiency)]);