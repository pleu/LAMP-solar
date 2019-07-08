clear;

% We now have Constants file for all these
% MtoNM = 1e9;

SS = SolarSpectrum.global_AM1p5;
SS = SS.truncate_spectrum_wavelength(280, 1000);

load('InputVariables');

pitchArray = 600;
diameterArray = 5:5:20;

%variables = {diameterArray};

vaTE = VariableArray({'d'}, {'nm'}, diameterArray);
vaTE.create_filenames('CuNW',['p', num2str(pitchArray), 'nm']);
sa = FDTDSimulationResultsArray.create(vaTE, 'frequency');

figure(1);
clf;
sa.contour('Wavelength', 'd','Transmission')
caxis([0 1]);
axis([280 1000 0 20])

figure(2);
clf;
sa.contour('Wavelength', 'd','Absorption')
caxis([0 1]);
axis([280 1000 0 20])

figure(3);
clf;
sa.contour('Wavelength', 'd','Reflection')
caxis([0 1]);
axis([280 1000 0 20])
