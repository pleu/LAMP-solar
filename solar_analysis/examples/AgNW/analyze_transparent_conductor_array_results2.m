clear;
pitchArray = [50 100 150];
va = VariableArray('p', 'nm', pitchArray);
va.create_filenames('AgNWTEd50nm');

sa = FDTDSimulationResultsArray.create(va, 'frequency');

figure(3);
clf;

sa.contour('p', 'Wavelength', 'Absorption')

figure(4)
clf;
sa.contour('p', 'Energy', 'Absorption')

