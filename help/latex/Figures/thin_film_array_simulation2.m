%THIN_FILM_ARRAY_SIMULATION
% Analyzes a thin film for perfectly reflecting back surface and
% antireflecting front surface
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
clear;
AM0 = 1;
GLOBAL_AM1p5 = 2;
DIRECT_AND_CIRCUMSOLAR_AM1p5 = 3;

thicknessArray = [2000 50000 200000];
materialName = 'Si';

solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM1p5);
materialData = MaterialData(materialName);
materialData.OpticalProperties = OpticalProperties('Si Tiedje extrap');
materialData.BandGap = 1240/1200;

%structure = ThinFilmArray(materialData, thicknessArray);
%sc = SolarCell(solarSpectrum, structure);
scArray = ThinFilm.create_thin_film_array(solarSpectrum, materialData, thicknessArray);
%scArray.SolarCell(4).Structure = Lambertian(materialData, 2000);

figure(1);
clf;
scArray.plot_absorption_versus_wavelength;

materialData.plot_shockley_queisser_limit(solarSpectrum, 'wavelength', 'Color', 'r');
axis([280 1400 0 1.1]);
%set(gcf, 'Position', [800 500 1440 1040]);
title(materialName);
grid off;
set(gca, 'XTick', [0 500 1000])
%set(gcf, 'Position',[800 500 560 420]);
set(gcf, 'Position',[800 500 700 560]);
legend('L = 2 microns', '50 microns', '200 microns', 'Shockley Queisser Limit', 'Location', 'Best');
legend('boxoff');


figure(2);
clf;
scArray = ThinFilm.create_thin_film_array(solarSpectrum, materialData, thicknessArray);
%thicknessArray = [2000 50000 200000];
scArray.SolarCell(4).Structure = Lambertian(materialData, 2000);
scArray.plot_absorption_versus_wavelength;
plot_shockley_queisser_limit(materialData, solarSpectrum, 'wavelength', 'Color', 'r');
axis([280 1400 0 1.1]);
%set(gcf, 'Position', [800 500 1440 1040]);
title(materialName);

grid off;
set(gca, 'XTick', [0 500 1000])
set(gcf, 'Position',[800 500 560 420])
legend({'L = 2 microns', '50 microns', '200 microns', ['L = 2 microns with';'    light trapping'], 'Shockley Queisser Limit'}, 'Location', 'Best');
legend('boxoff');
set(gcf, 'Position',[800 500 700 560]);
% sctfArray.plot_absorption_versus_energy;
% sctfArray.SCTF(1).plot_shockley_queisser_limit('energy', 'Color', 'r');
% axis([0 4 0 1]);% set(gcf, 'Position', [800 500 1440 1040]);
% title(materialName);
% 
minThickness = 2000; % nm
maxThickness = 2e6; % nm
thicknessArray = 10.^(linspace(log10(minThickness), log10(maxThickness)));
scArrayThinFilm = ThinFilm.create_thin_film_array(solarSpectrum, materialData, thicknessArray);
scArrayThinFilm = scArrayThinFilm.simulate_all;


scArray = Lambertian.create_Lambertian_array(solarSpectrum, materialData, thicknessArray);
scArray = scArray.simulate_all;

figure(2);
clf;
scArrayThinFilm.semilogx_ultimate_efficiency_versus_independent_variable('Color', 'b');
hold on;
scArray.semilogx_ultimate_efficiency_versus_independent_variable('Color', 'g');
set(gcf, 'Position', [800 500 1440 1040]);
grid off;
scArray.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArray.IndependentVariableLabel = 'Thickness (microns)';

materialDataOptimum = MaterialData('Si');
materialDataOptimum.BandGap = 1240/1200;
structureOptimum = StepFunctionAbsorber(materialDataOptimum);
scOptimum = SolarCell(solarSpectrum, structureOptimum);
scOptimum = scOptimum.runSQSimulation;

% figure(3);
% for i = 1:scArray.NumSolarCell
%   VOC(i) = scArray.SolarCell(i).SQSimulation.VOC;
% end
% semilogx(scArray.IndependentVariable, VOC);
% set(gcf, 'Position', [800 500 1440 1040]);
% grid on;
% 
figure(3);
clf;
scArray.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArray.IndependentVariableLabel = 'Thickness (microns)';
scArrayThinFilm.IndependentVariable = thicknessArray*Constants.UnitConversions.NMToMicrons;
scArrayThinFilm.IndependentVariableLabel = 'Thickness (microns)';

scArrayThinFilm.semilogx_limiting_efficiency_versus_independent_variable('Color', 'b');
hold on;
scArray.semilogx_limiting_efficiency_versus_independent_variable('Color', 'g');
axis([0.1 2e3 .15 .35]);
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
plot([0.1 2e3], [scOptimum.LimitingEfficiency scOptimum.LimitingEfficiency], 'r');

legend('Thin Film with Ideal Reflection', 'Thin Film with Light Trapping');

figure(4);
clf;
scArrayThinFilm.semilogx_limiting_eff_detailed_versus_independent_variable('Color', 'g');
hold on;
scArray.semilogx_limiting_eff_detailed_versus_independent_variable('Color', 'b');
set(gcf, 'Position', [800 500 1440 1040]);

plot([0.1 2e3], [scOptimum.LimitingEfficiency scOptimum.LimitingEfficiency], 'r');
axis([1 2e3 0 .35]);

legend('Ideal Reflection', 'With Light Trapping', 'Shockley-Queisser limit', 'Location', 'Best')
 set(gcf, 'Position',[800 500 840 600]);
 legend('boxoff');
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