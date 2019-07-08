function test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
%pitch = 500;
holeWidth = [20 30];
%wavelength = 20;
wavelength = [20 30 40];

st = OneDSlit(holeWidth);
sc = SolarSpectrum.create_single_wavelength(wavelength);


obj = DiffractionSimulation(st, sc, holeWidth);
figure(1);
clf;
obj.plot_diffraction_patterns();

%legend(num2str([dp.Wavelength]))
%obj.calc_diffraction_patterns();
%obj = DiffractionSimulation(st, sc);




end

