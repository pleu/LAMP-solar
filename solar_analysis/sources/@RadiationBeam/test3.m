clear;
latitudes = 0:2:60; %[20 40]; % latitude in degrees
%latitudes = 20;
%latitudes = 40; % latitude in degrees
days = linspace(0, 365);
%betas = linspace(0, 80, 81);
%betas = linspace(0, 72);
betaFraction = linspace(0, 1.8);
betaFractionFlag = 1;
%gammas = [0 20 40];
gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);
rb = RadiationBeam(latitudes, days, betaFraction, gammas, 'fixed', betaFractionFlag);

figure(1);
clf;
rb.contour_irradiance('Latitude', 'BetaFraction','TotalA', [1000 1500 2000 2500]);
ylabel('Tilt Fraction of Latitude');

hold on;

latitudeCutoff = 20;
[val, indY] = max(squeeze(real(rb.ITmA)), [], 2);
hold on;
plot(latitudes(latitudes>=latitudeCutoff), betaFraction(indY(latitudes>=latitudeCutoff)), 'w:');



