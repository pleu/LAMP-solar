clear;
%latitudes = linspace(0, 60) %[20 40]; % latitude in degrees
latitudes = 20;
%latitudes = 40; % latitude in degrees
days = linspace(0, 365);
%betas = linspace(0, 80, 81);
betas = linspace(0, 72);
%gammas = [0 20 40];
gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);
rb = RadiationBeamDay(latitudes, days,betas,gammas);

figure(1);
clf;
rb.contour_irradiance('Days', 'Beta','Total');

xlabel('Day');

betas = [20 30 40 50];
rb2 = RadiationBeamDay(latitudes, days,betas,gammas);
figure(2);
clf;
rb2.plot_irradiance('Days', 'Beta','Total');

%rb.plot_irradiation('Day', 'Total', 'Beta');

