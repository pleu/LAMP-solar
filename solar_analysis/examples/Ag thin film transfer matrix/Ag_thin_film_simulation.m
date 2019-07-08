clear;
materials = {'Air'; 'Ag'; 'Air'};
thicknesses = [0 20 0];

tfArray = ThinFilmLayer.create_array(materials, thicknesses);
solarSpectrum = SolarSpectrum.global_AM1p5();
%solarSpectrum = SolarSpectrum.create_single_wavelength(500);
%solarSpectrum = SolarSpectrum('test', [500; 600], [1; 1]);

tm = TransferMatrixSimulation(solarSpectrum, tfArray);
tm.simulate;

disp(['Silver Transparency: ', num2str(tm.TsIntegrated)]);
%tmSimulation = TransferMatrixSimulation(