clf;
clear;
temperature = 5800;
temperature2 = 310;
%ssArray = SolarSpectrum.create_solar_spectrum_array(numSpectrum);
energyMin = 1e-2;
energyMax = 6;
wavelength = linspace(Photon.ConvertEnergyToWavelength(energyMin), ...
  Photon.ConvertEnergyToWavelength(energyMax), 2000);

%ssArray(1) = SolarSpectrum.create_blackbody_spectrum(temperature, wavelength);

%ssArray.plot_irradiance_versus_energy();
%axis([0 0.5 0 1e-1])
ssArray(1) = SolarSpectrum.global_AM0();
ssArray(2) = SolarSpectrum.global_AM1p5();
ssArray(3) = SolarSpectrum.direct_AM1p5();
figure(1);
clf;
ssArray.plot_irradiance_versus_wavelength;
legend off;
%plot(ssArray.Energy, ssArray.Irradiance);
xlabel('Energy (eV)');
ylabel({'Photon Flux Density','(# photons*m^{-2}eV^{-1})'});
grid on;

figure(2)
ssArray(2).plot_photon_flux_versus_energy();
title('');
%axis([0 4 0 1000])
%axis([0 2000 0 2.5])