%SIMULATE_SOLAR_CELL
% Simulates solar cell 
% 
% See also PLOT_ULTIMATE_EFFICIENCY_AS_FUNCTION_OF_BANDGAP
% 
% Copyright 2011
% Paul Leu

materialName = 'Si';
material = MaterialType.create(materialName);
solarSpectrum = SolarSpectrum.global_AM1p5;

stepFunctionAbsorber = StepFunctionAbsorber('Si', material.BandGap,...
  solarSpectrum.Energy);
sc = SolarCell(solarSpectrum, stepFunctionAbsorber, material);
sc = sc.runSQSimulation;

sc = ShockleyQueisser(

figure(1);
clf;
sc.SQSimulation.plot_IV;

disp(['Ultimate Efficiency: ', num2str(sc.UltimateEfficiency)]);
disp(['Limiting Efficiency: ', num2str(sc.LimitingEfficiency)]);