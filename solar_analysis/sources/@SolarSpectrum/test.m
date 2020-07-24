function test
% TEST
% tests the SolarSpectrum class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  ss = SolarSpectrum.global_AM1p5;
  assert(ss.Wavelength(1) == 280);
  assert(ss.Irradiance(1) == 4.7309e-23);
  assert(is_numerically_equal(ss.PowerDensity, 1.000470703609345e+03));
  assert(is_numerically_equal(ss.Energy(1), 4.428006131009940));
  assert(is_numerically_equal(ss.Frequency(1), 1.070687350000000e+15));
  assert(is_numerically_equal(ss.IrradianceEnergy(1), 2.990962435045072e-21));
  assert(is_numerically_equal(ss.PhotonFlux(1), 4.21592036116882e-003));
  assert(is_numerically_equal(ss.NumWavelength, 2002));
  clf;
  ss.plot_irradiance_versus_wavelength;
  
  temperature = 5760;
  %ssArray = SolarSpectrum.create_solar_spectrum_array(numSpectrum);
  ssArray(1) = SolarSpectrum.global_AM0();
  ssArray(2) = SolarSpectrum.global_AM1p5();
  ssArray(3) = SolarSpectrum.create_blackbody_spectrum(temperature);  
  
  ssArray = ssArray.truncate_spectrum_visible;
  
  figure(3);
  clf;
  ssArray.plot_irradiance_versus_wavelength();
  set(gcf, 'Position', [800 500 1440 1040]);
  
  figure(4);
  clf;
  ssArray.plot_irradiance_versus_energy();
  set(gcf, 'Position', [800 500 1440 1040]);

end

