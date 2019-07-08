filename = 'UniformCylinderTheta0degTE';

minWavelength = 280;
maxWavelength = 1100;
sr = FDTDSimulationResults(filename);
sr.truncate_wavelength(minWavelength, maxWavelength);

ss = SolarSpectrum.global_AM1p5();
ss.truncate_spectrum_wavelength(minWavelength, maxWavelength);


figure(1);
clf;
sr.ReflectionResults.plot_versus_wavelength;


figure(2);
clf;
sr.TransmissionResults.plot_versus_wavelength;

figure(3);
clf;
sr.AbsorptionResults.plot_versus_wavelength;


id = IntegratedData(ss, sr);