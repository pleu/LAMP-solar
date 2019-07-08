%PLOT_SOLAR_SPECTRUM
% Plots the solar spectrum.
% 
% Copyright 2011
% Paul Leu
clear all;
SSArray = SolarSpectrum.read_ASTMG173_all();
figure(1);
clf;
SSArray.plot_irradiance_versus_wavelength();
%set(gcf, 'Position', [800 500 960 720]);
%legend('boxoff');
set(gcf, 'Position', [800 500 1200 900]);

figure(2);
clf;
SSArray.plot_irradiance_versus_energy();
set(gcf, 'Position', [800 500 960 720]);
%set(gcf, 'Position', [800 500 1440 1040]);
set(gcf, 'Position', [800 500 1200 900]);
%legend('boxoff');



