clear;
filename = 'bSi_50um';
sd = SpectrophotometerData(filename);

figure(1);
clf;
sd.AbsorptionResults.plot_versus_wavelength();

figure(2);
clf;
sd.Reflection.plot_versus_wavelength();

figure(3);
clf;
sd.TransmissionTotal.plot_versus_wavelength();

material = MaterialType.create('Si');

ssTruncate = SolarSpectrum.global_AM1p5;
%sc1 = SolarCell(ss, sd, material);
ssTruncate.truncate_spectrum_energy(material.BandGap, max(ssTruncate.Energy))

ss = SolarSpectrum.global_AM1p5;

sc = SolarCell(ss, sd, material);

scTruncate = SolarCell(ssTruncate, sd, material);
