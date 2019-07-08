

sr = FDTDSimulationResults.read_absorption_file('120nm_bare_PbS_QD', 'frequency');
sr(2) = FDTDSimulationResults('Core-shellNanospherep200nmIntegrated', 'frequency');

ss = SolarSpectrum.global_AM1p5;
ss.truncate_spectrum_wavelength( min(sr(1).ReflectionResults.Wavelength), 1000);

figure(1);
clf;
sr.plot_versus_wavelength('Absorption');
axis([300 1000 0 1]);
legend('120 nm thick PbS QD', 'with Au nanoparticles');

legend('Location', [0.5 0.7 0.15 0.05]);

legend('boxoff');

figure(2);
clf;
optionplot_add_energy_top_axis(sr(1).AbsorptionResults.Wavelength, sr(2).AbsorptionResults.Data./sr(1).AbsorptionResults.Data);
axis([300 1000 0 1.6]);
set(gca, 'yTick', 0:0.2:1.6);
hold on;
plot([0 1000], [1 1], 'k--');
ylabel('g(\lambda)');

material = MaterialType.create('PbS');

sc = SolarCell(ss, sr(1), material)
sc(2) = SolarCell(ss, sr(2), material)

disp('Short Circuit Current');
sc(1).CurrentSC
disp('Short Circuit Current');
sc(2).CurrentSC

disp('Short Circuit Current Enhancement');

sc(2).CurrentSC/sc(1).CurrentSC


