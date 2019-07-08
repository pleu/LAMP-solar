%ANALYZE_TRANSPARENT_CONDUCTOR_RESULTS
% Analyzes the results from a single FDTD simulation
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

clear all;

load('InputVariables');
filename1 = 'AgNanomeshTEt350nmd520nmp900nm';
pitch = 900; 
diameter = 520;
%sr1 = FDTD1D(filename1, 'frequency', pitch, Circle(diameter));

sr = FDTDSimulationResults(filename1);
sr.plot_versus_wavelength('Transmission');
%plot1 = plot(sr1.TransmissionResults.Wavelength,sr1.TransmissionResults.Data,'Color','r');

xlabel('Wavelength (nm)');
ylabel('Transmission');
axis([400 1000 0 1])
% legend = legend([plot1 plot2],{'Experiment','Simulation'});
% 
% set(legend,'Box','off','Position',[0.57858150415664 0.27311379687261 0.221912016326112 0.21780386137997]);

%clf;
% sr.plot_results_versus_energy;
% sr.plot_results_versus_wavelength;
% 
% %clf;
% % sr.plot_results_versus_energy;
% sr.plot_results_versus_wavelength;
% 
% ss = SolarSpectrum.global_AM1p5;
% ss = ss.truncate_spectrum_wavelength(400, 1000);
% material = MaterialType.create(materialName);
% 
% tc = TransparentConductor(ss, sr, material);
% 
% a = 1 - tc.TransmissionIntegrated - tc.ReflectionIntegrated;
% 
% 
% disp(['Solar Transmission: ', num2str(tc.TransmissionIntegrated)]);
% % disp(['Sheet Resistance: ', num2str(tc.SheetResistance)]);
