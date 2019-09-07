filename = 'SiNWNormal';

minWavelength = 280;
maxWavelength = 1100;
wavelengthQuery = 550;

srNormal = FDTDSimulationResults(filename);

filename = 'SiNWTE';
srTE = FDTDSimulationResults(filename);

filename = 'SiNWTM';
srTM = FDTDSimulationResults(filename);

%sr.truncate_wavelength(minWavelength, maxWavelength);

srNormal.ReflectionResults.query_monitor_data_at_wavelength(wavelengthQuery)
srTE.ReflectionResults.query_monitor_data_at_wavelength(wavelengthQuery)
srTM.ReflectionResults.query_monitor_data_at_wavelength(wavelengthQuery)

ss = SolarSpectrum.global_AM1p5();
ss.truncate_spectrum_wavelength(minWavelength, maxWavelength);

idSSNormal = IntegratedData(ss, srNormal);
idSSNormal.ReflectionIntegrated

idSSTE = IntegratedData(ss, srTE);
idSSTE.ReflectionIntegrated

idSSTM = IntegratedData(ss, srTM);
idSSTM.ReflectionIntegrated

srTE.plot_versus_wavelength('Reflection');


