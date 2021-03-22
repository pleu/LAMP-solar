clear;
latitudes = [40]; % latitude in degrees
%latitudes = 40; % latitude in degrees
days = linspace(0, 365);
%betas = linspace(0, 80, 81);
betas = [0 15 30];
%gammas = [0 20 40];
gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);

betaFraction = [0 0.3 0.6 0.9];
betaFractionFlag = 1;
rb = RadiationBeam.create_with_betaFraction(latitudes, days,betaFraction,gammas);

figure(1);
clf;
rb.plot_irradiance('Day', 'Beta', 'TotalD');