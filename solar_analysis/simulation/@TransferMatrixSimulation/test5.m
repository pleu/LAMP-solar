%tmSimulation = TransferMatrixSimulation(


%material = Material

% Simulate 20 nm thick Ag
clear;
materials = {'Air'; 'Air'; 'SiO2'};
thicknesses = [0 124 0];

tfArray = ThinFilmLayer.create_array(materials, thicknesses);

tfArray(2).Material.OpticalProperties.N = [1.2; 1.2];
solarSpectrum = SolarSpectrum.global_AM1p5();
%solarSpectrum = SolarSpectrum.create_single_wavelength(500);
%solarSpectrum = SolarSpectrum('test', [500; 600], [1; 1]);

tm = TransferMatrixSimulation(solarSpectrum, tfArray);
tm.simulate;



%disp(['Silver Transparency: ', num2str(tm.TsIntegrated)]);
%tmSimulation = TransferMatrixSimulation(