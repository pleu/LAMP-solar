clear;
latitudes = 0:2:60; %[20 40]; % latitude in degrees
%latitudes = 20;
%latitudes = 40; % latitude in degrees
days = linspace(0, 365);
%betas = linspace(0, 80, 81);
betas = linspace(0, 72);
%beta = linspace(0, 90, 301);
betaFractionFlag = 0;
%gammas = [0 20 40];
gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);
rb = RadiationBeam(latitudes, days, betas, gammas, 'fixed', betaFractionFlag);

figure(1);
clf;
rb.contour_irradiance('Latitude', 'Beta','TotalA', [1000 1500 2000 2500]);
ylabel('Tilt (^\circ)');
% 
% latitudeCutoff = 20;
% [val, indY] = max(squeeze(real(rb.ITmA)), [], 2);
% zQ = rb.extract('TotalA',{'Latitude', 'Betas'},...
%   [latitudes(latitudes>=latitudeCutoff);betas(indY(latitudes>=latitudeCutoff))]');
% 
% figure(2);
% clf;
% plot(latitudes(latitudes>=latitudeCutoff), zQ);

%betas(indY(latitudes>=latitudeCutoff))

% hold on;
% latitudeCutoff = 20;
% [val, indY] = max(squeeze(real(rb.ITmA)), [], 2);
% hold on;
% plot(latitudes(latitudes>=latitudeCutoff), beta(indY(latitudes>=latitudeCutoff)), 'w:');
% 
% [varXIndex, varX, xAxisLabel, varXUnits] = rb.get_variable(xVariable);
% [varYIndex, varY, yAxisLabel, varYUnits] = rb.get_variable(yVariable);
% 


%figure(2);
%output = squeeze(rb.ITmA);
% output(latitudes(latitudes>=latitudeCutoff), beta(indY(latitudes>=latitudeCutoff)));
% %beta(indY(latitudes>=latitudeCutoff)
% plot(latitudes(latitudes>=latitudeCutoff), beta(indY(latitudes>=latitudeCutoff)), 'w:');
