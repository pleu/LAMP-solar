%function testArray()
  %ssArray = SolarSpectrum.create_solar_spectrum_array(numSpectrum);
  temperature = 5760;
  ssArray(1) = SolarSpectrum.global_AM0();
  ssArray(2) = SolarSpectrum.global_AM1p5();
  ssArray(3) = SolarSpectrum.create_blackbody_spectrum(temperature);  

  figure(3);
  clf;
  ssArray.plot_irradiance_versus_wavelength();
  set(gcf, 'Position', [800 500 1440 1040]);

%end
