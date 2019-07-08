function test3()
%TEST Summary of this function goes here
%   Detailed explanation goes here
%pitch = 500;


diameter = 20;
wavelength = [20];
%wavelength = [20 30];

st = CircularHole(diameter);
sc = SolarSpectrum.create_single_wavelength(wavelength);

obj = DiffractionSimulation(st, sc);
figure(1);
clf;

obj.plot_diffraction_patterns();

% pitch = 50;
% number = 1;



end

