%ANALYZE_TRANSPARENT_CONDUCTOR_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

clear;

load('InputVariables');
filename = 'AgNWTEd50nmp50nm';
pitch = 50; 
diameter = 10;
sr = FDTD1D(filename, 'frequency', pitch, Circle(diameter));

%clf;
sr.plot_results_versus_energy;
%sr.plot_results_versus_wavelength;

ss = SolarSpectrum.global_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 2000);
material = MaterialType.create(materialName);

tc = TransparentConductor(ss, sr, material);

a = 1 - tc.TransmissionIntegrated - tc.ReflectionIntegrated;


disp(['Solar Transmission: ', num2str(a)]);
disp(['Sheet Resistance: ', num2str(tc.SheetResistance)]);