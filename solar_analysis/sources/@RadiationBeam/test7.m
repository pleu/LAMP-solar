clear;
latitudes = 0:2:60;
%latitudes = [40]; % latitude in degrees
%latitudes = 40; % latitude in degrees
days = linspace(0, 365, 30);
%days = 0;
betas = []; %linspace(0, 90, 81);

betaFractionFlag = 0;
%gammas = [0 20 40];
gammas = [];

moduleType = '1axisNS';
rb = RadiationBeam(latitudes, days, betas, gammas, moduleType, betaFractionFlag);
%strncmpi(rb.ModuleType, '1axisEW', 5)

figure(1);
clf;
rb.plot_irradiance('Day', 'Latitude', 'TotalD');