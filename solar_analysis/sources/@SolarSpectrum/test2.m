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
  ssArray1(1) = SolarSpectrum.global_AM1p5();
  figure(1);
  clf;
  ssArray1.plot_irradiance_versus_wavelength();
 
  %ssArray1.plot_irradiance_versus_energy();
  title('');
  %axis([0 4 0 1000])
  %axis([0 2000 0 2.5])