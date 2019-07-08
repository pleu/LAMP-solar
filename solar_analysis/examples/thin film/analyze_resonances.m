load('InputVariables');
%filename = 'LinyouThinFilmt400nm';
filename = 'LinyouThinFilmt400nmBackMetal';
sr = FDTDSimulationResults(filename);
%ma = MaterialType.create(materialName);

figure(1);
clf;
sr.plot_results_versus_wavelength;

minWavelength = 2000;
maxWavelength = 3000;

ind = find(sr.AbsorptionResults.Wavelength > minWavelength & ...
  sr.AbsorptionResults.Wavelength < maxWavelength);
[maxValue, maxInd] = max(sr.AbsorptionResults.Data(ind));
sr.AbsorptionResults.Wavelength(ind(maxInd))
maxValue
plot(sr.AbsorptionResults.Wavelength(ind(maxInd)), maxValue, 'o');
