% function analyze_thin_film_results()
%ANALYZE_THIN_FILM_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
clear all;
filename = 'TiO2ThinFilm5000nm';
%materialName = 'TiO2rutile_parallel'
sr = FDTDSimulationResults(filename, 'Si', 'Wavelength');
sr.ReflectionResults.Data = sr.ReflectionResults.Data/100;
sr.ReflectionResults.Data = sr.ReflectionResults.Data - ...
  min(sr.ReflectionResults.Data);
sr.TransmissionResults.Data = sr.TransmissionResults.Data/100;
sr.AbsorptionResults = sr.calc_absorption_results;

[sr] = sr.process_results;

%sr.MaterialData = MaterialData(materialName);
sr.plot_results_versus_wavelength;


materials = {'Air'; 'TiO2rutile_parallel'; 'SiO2glass'};
thicknesses = [0; 5000; 0];  % if thickness is 0 then it is at the front or 
                            % back                            
tfArray = ThinFilmLayerStructure(materials, thicknesses);

solarSpectrum = SolarSpectrum.global_AM1p5();
tm = TransferMatrixSimulation(solarSpectrum, tfArray);
