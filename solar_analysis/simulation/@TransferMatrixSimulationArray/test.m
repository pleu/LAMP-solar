clear;
materials = {'Air'; 'Ag'; 'Air'};
solarSpectrum = SolarSpectrum.global_AM1p5();
solarSpectrum = solarSpectrum.truncate_spectrum_wavelength(280, 2000);

thicknessVector = linspace(0, 100)';
%[1 2 3 4 5 10 20 30 40 50 60 70 80 90 100]';
variableString = 't';
variableUnitsArray = 'nm';

va = VariableArray(variableString, variableUnitsArray, thicknessVector);
tma = TransferMatrixSimulation.create_array(solarSpectrum, materials, va);
tmsa = TransferMatrixSimulationArray.create(tma, va);

tmsa.simulate;

figure(2);
clf;
plot(va.Values, tmsa.TransmissionS, 'b');
hold on;
plot(va.Values, tmsa.ReflectionS, 'r');
plot(va.Values, tmsa.AbsorptionS, 'g');