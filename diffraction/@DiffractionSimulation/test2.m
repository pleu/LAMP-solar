function test2()
%TEST Summary of this function goes here
%   Detailed explanation goes here
%pitch = 500;


pitch = 50;
numbers = [1; inf];
holeWidth = 20;
wavelength = [20];
%wavelength = [20 30];

st = OneDSlitArray(pitch, numbers, holeWidth);
%st = OneDGrating(pitch, number, holeWidth);
sc = SolarSpectrum.create_single_wavelength(wavelength);

obj = DiffractionSimulation(st, sc, numbers);
% figure(1);
% clf;
% obj.plot_diffraction_patterns();


% number = inf;
% st2 = OneDSlitArray(pitch, number, holeWidth);
% obj(2) = DiffractionSimulation(st2, sc);

figure(1);
hold on;
%clf;
obj.plot_diffraction_patterns;


%obj.calc_diffraction_patterns();
%obj = DiffractionSimulation(st, sc);




end

