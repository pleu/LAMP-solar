variableValues = [2330 9960];
variableNames = {'t'};
variableUnits = {'nm'};

va = VariableArray(variableNames, variableUnits, variableValues);
va.create_filenames('SiThinFilm');

sa = FDTDSimulationResultsArray.create(va, 'frequency');

%sa = FDTDSimulationResults.create_array(va.Filenames, 'frequency');

