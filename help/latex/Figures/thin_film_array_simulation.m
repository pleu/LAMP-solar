%THIN_FILM_ARRAY_SIMULATION
% Analyzes a thin film for perfectly reflecting back surface and
% antireflecting front surface
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
clear;

thicknessArray = [2000, 10000, 100000];
materialName = 'Si';

ss = SolarSpectrum.global_AM1p5;

materialData = MaterialType.create(materialName);
materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
materialData.BandGap = 1240/1200;

va = VariableArray('thickness', 'nm', thicknessArray);
scArray = ThinFilm.create_thin_film_array(ss, va, materialData);

figure(1);
clf;
scArray.plot_absorption('Wavelength');


scArray.plot_versus_variable(scArray.UltimateEfficiency, 'Ultimate Efficiency (%)', 1);



plot_shockley_queisser_limit(materialData, solarSpectrum, 'wavelength', 'Color', 'r');
axis([280 1400 0 1.1]);
set(gcf, 'Position', [800 500 1440 1040]);
title(materialName);
legend('2 microns', '10 microns', '100 microns', 'Shockley Queisser Limit');

% sctfArray.plot_absorption_versus_energy;
% sctfArray.SCTF(1).plot_shockley_queisser_limit('energy', 'Color', 'r');
% axis([0 4 0 1]);% set(gcf, 'Position', [800 500 1440 1040]);
% title(materialName);
% 
minThickness = 2000; % nm
maxThickness = 2e6; % nm
thicknessArray = 10.^(linspace(log10(minThickness), log10(maxThickness)));
scArray = create_thin_film_array(solarSpectrum, materialData, thicknessArray);
scArray = scArray.simulate_all;

figure(2);
clf;
scArray.semilogx_ultimate_efficiency_versus_independent_variable;
hold on;
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
scArray.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArray.IndependentVariableLabel = 'Thickness (microns)';

materialDataOptimum = MaterialData('Si');
materialDataOptimum.BandGap = 1240/1200;
structureOptimum = StepFunctionAbsorber(materialDataOptimum);
scOptimum = SolarCell(solarSpectrum, structureOptimum);
scOptimum = scOptimum.runSQSimulation;

figure(3);
for i = 1:scArray.NumSolarCell
  VOC(i) = scArray.SolarCell(i).SQSimulation.VOC;
end
semilogx(scArray.IndependentVariable, VOC);
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
% 
figure(4);
clf;
scArray.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArray.IndependentVariableLabel = 'Thickness (\mum)';
scArray.semilogx_limiting_efficiency_versus_independent_variable;
hold on;
axis([0.1 2e3 .15 .35]);
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
plot([0.1 2e3], [scOptimum.LimitingEfficiency scOptimum.LimitingEfficiency], 'r');


figure(5);
clf;
scArray.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArray.IndependentVariableLabel = 'Thickness (\mum)';
scArray.semilogx_limiting_eff_detailed_versus_independent_variable;
hold on;
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
plot([0.1 2e3], [scOptimum.LimitingEfficiency scOptimum.LimitingEfficiency], 'r');
axis([0.1 2e3 .15 .35]);
 
% figure(4);
% clf;
% nmToMicrons = 1e-3;
% scArray.IndependentVariable = thicknessArray*nmToMicrons;
% scArray.IndependentVariableLabel = 'Thickness (\mum)';

% [scArray] = scArray.include_auger_recombination;
% scArray.semilogx_limiting_efficiency_versus_independent_variable;
% set(gcf, 'Position', [800 500 1440 1040]);
% axis([1 2e3 0.15 0.34])
% grid on;


% 
%sctfArray = SolarCellThinFilmArray(SS, MD, thicknessArray);
% 
% figure(3);
% clf;
% sc.Structure.plot_limiting_efficiency_versus_thickness;
% set(gcf, 'Position', [800 500 1440 1040]);
% grid on;


%sr.PlotResults;
%sctf.AbsorptionResults.plot_versus_wavelength;

%disp(['Ultimate Efficiency: ', num2str(sr.UltimateEfficiency)]);