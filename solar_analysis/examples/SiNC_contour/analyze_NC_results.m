%ANALYZE_NW_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

clear;

materialName = 'Si';
filename = 'SiNCdTop80dBot80';
sr = FDTDSimulationResults(filename);

%clf;
sr.plot_results_versus_energy;
%sr.plot_results_versus_wavelength;

ss = SolarSpectrum.global_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 2000);
material = MaterialType.create(materialName);

sc = SolarCell(ss, sr, material);
