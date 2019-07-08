
clear;
materials = {'Air'; 'Si'; 'Air'};
%materials = {'Air'; 'Si'; 'PEC'};

theta = linspace(0,pi/2-1/180*pi);
thicknesses = [0 2330 0];

tfArray = ThinFilmLayer.create_array(materials, thicknesses);
solarSpectrum = SolarSpectrum.global_AM1p5();
%solarSpectrum = SolarSpectrum.create_single_wavelength(500);
%solarSpectrum = SolarSpectrum('test', [500; 600], [1; 1]);

tm = TransferMatrixSimulation.empty(length(theta),0);
for i = 1:length(theta)
  tm(i) = TransferMatrixSimulation(solarSpectrum, tfArray, theta(i));
  tm(i).simulate;
end

variableUnits = 'deg';
variableNames = 'Theta';
va = VariableArray(variableNames, variableUnits, theta);

tma = TransferMatrixSimulationArray.create(tm,va);
figure(1);
clf;
tma.contour('Wavelength', 'Theta', 'TEAbsorption',200,0);

figure(2);
clf;
tma.contour('Wavelength', 'Theta', 'TMAbsorption',200,0);
