clear;
latitudes = [40]; % latitude in degrees
%latitudes = 40; % latitude in degrees
days = linspace(0, 365, 30);
%days = 0;
betas = linspace(0, 90, 81);

%latitudeDeg = 40; % latitude in degrees
%betas = 36; % tilt angle in degrees
%gammas = -30;
%betas = 0;
%betas = [0 15 30];
%betaFraction = 0.9;
%beta = 36;
%gammas = [0 20 40];
%gammas = 0;
gammas = linspace(-180, 180, 20);
%gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);
rb = RadiationBeam(latitudes, days, betas, gammas);

figure(1);
clf;
rb.contour_irradiance('Beta', 'Gamma','TotalA', [500 1000 1500 2000], 'polar','RadialTickSpacing', [10:10:80], 'RadLabels', 8);
ylabel('Azimuth (^\circ)');
title('');

figure(2);
clf;
rb.contour_irradiance('Beta', 'Gamma','TotalA', [500 1000 1500 2000], 'cartesian');
ylabel('Azimuth (^\circ)');
