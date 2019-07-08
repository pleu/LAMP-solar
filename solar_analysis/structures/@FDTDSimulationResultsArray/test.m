function [] = test()
filmThicknessArray = [60 200 300];
va = VariableArray({'t'}, {'nm'}, filmThicknessArray);
va.create_filenames('SiThinFilm', '');

sr = FDTDSimulationResultsArray.create(va);
sr.Simulations.plot_results_versus_wavelength(5);

figure(1)
sr.contour('Wavelength', 't', 'Absorption')
