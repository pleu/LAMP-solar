clear;
temperature = Constants.LightConstants.T_sun;
%SSArray = SolarSpectrumArray(2);
%ssArray(2) = SolarSpectrum.global_AM1p5();
%ssArray(1) = SolarSpectrum.create_blackbody_spectrum(temperature);  
ssArray(1) = SolarSpectrum.create_blackbody_spectrum(6000);  

%ssArray(2) = SolarSpectrum.global_AM0();


figure(3);
clf;
ssArray.plot_irradiance_versus_wavelength();
%set(gcf, 'Position', [800 500 960 720]);
%set(gcf, 'Position', [800 500 1440 1040]);
