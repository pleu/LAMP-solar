function analyze_thin_film_results_visible()
%ANALYZE_THIN_FILM_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

load('InputVariables');
filename = 'LinyouThinFilmt400nmBackMetal';
sr = FDTDSimulationResults(filename);
%ma = MaterialType.create(materialName);

figure(1);
clf;
sr.plot_results_versus_wavelength;




%disp(['Ultimate Efficiency: ', num2str(sr.UltimateEfficiency)]);