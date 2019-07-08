clear all;
diameter = 5;
pitch = 10;

ss = SolarSpectrum.global_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 1000);

variables = [diameter pitch];
variableStringArray = {'d', 'p'};
variableUnitsArray = {'nm', 'nm'};

material = MaterialType.create('Ag');
va = VariableArray(variableStringArray, variableUnitsArray, variables);
va.create_filenames('AgNWTE');

sr = FDTD1D(va.Filenames{1}, 'Frequency', variables(2), Circle(diameter));

va.create_filenames('AgNWTM');
tc1 = TransparentConductor(ss, sr, material)

sr2 = FDTD1D(va.Filenames{1}, 'Frequency', variables(2), Circle(diameter));
tc2 = TransparentConductor(ss, sr2, material)

va.create_filenames('AgNWTE');
va.append_filenames('AgNWTM');

srAvg = FDTD1D.create_array(va.Filenames, 'Frequency', variables(2), Circle(diameter));
%srAvg(2) = FDTD1D(va.Filenames{2}, 'Frequency', variables(2), Circle(diameter));

tcAvg = TransparentConductor(ss, srAvg, material)
  



