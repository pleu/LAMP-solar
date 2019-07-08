
load('InputVariables');
filename = 'LinyouThinFilmt400nm';
sr = FDTDSimulationResults(filename);
%ma = MaterialType.create(materialName);

figure(1);
clf;
sr.plot_results_versus_wavelength;

minWavelength = 2000;
maxWavelength = 4000;

sr.AbsorptionResults.Wavelength