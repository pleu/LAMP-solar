function testArray2()
  ssArray = SolarSpectrum.global_AM1p5();
  
  figure(1);
  clf;
  plot(ssArray.Wavelength, ssArray.PhotonFluxNM);
  xlabel('Wavelength (nm)');
  ylabel({'Photon Flux Density', '(#/(m^2 sec nm))'});
  axis([300 2000 0 5e18]);
  %obj.Irradiance*Constants.LightConstants.HC./(obj.Energy).^2;
  %ssArray.plot_irradiance_versus_wavelength();
  %set(gcf, 'Position', [800 500 1440 1040]);

end