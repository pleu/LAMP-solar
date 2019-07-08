
clear;
%sa = FDTDSimulationResultsArray.create(va, 'frequency');

%sa = FDTDSimulationResults.create_array(va.Filenames, 'frequency');
%clf;
%sa2 = FDTDSimulationResultsArray.create(va, 'frequency');
%sa.plot_versus_wavelength('Reflection');

sr = FDTDSimulationResults.read_absorption_file('50nm_bare_PbS', 'frequency');
%sa.plot_results_versus_energy;

sr.ReflectionResults.plot_versus_wavelength
