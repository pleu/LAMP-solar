clear;
%latitudes = linspace(0, 60) %[20 40]; % latitude in degrees
latitudes = 40;
%latitudes = 40; % latitude in degrees
days = linspace(0, 365, 40);
%betas = linspace(0, 80, 81);
betas = linspace(0, 72, 301);
%gammas = [0 20 40];
gammas = 0;

rb = RadiationBeam(latitudes, days,betas,gammas);

figure(1);
clf;
rb.contour_irradiance('Days', 'Beta','TotalD', [3 4 5 6 7 8]);

xlabel('Day');