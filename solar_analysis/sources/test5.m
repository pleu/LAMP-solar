clear;
latitudes = [0  1 2:2:60]; %[20 40]; % latitude in degrees
%latitudes = 20;
%latitudes = 40; % latitude in degrees
days = linspace(0, 365);
%betas = linspace(0, 80, 81);
%betas = -20:1:90;
betas = linspace(-20, 90, 401);
betaFractionFlag = 0;
%gammas = [0 20 40];
gammas = 0;

%rb = RadiationBeamDay(latitudes, days,betas,gammas);
rb = RadiationBeam(latitudes, days, betas, gammas, betaFractionFlag);

figure(1);
clf;
rb.contour_irradiance('Latitude', 'Beta','TotalA', [1000 1500 2000 2500]);
ylabel('Tilt (^\circ)');

latitudeCutoff = 1;
[maxITmA, indY] = max(squeeze(real(rb.ITmA)), [], 2);
betaOpt = betas(indY(latitudes>=latitudeCutoff));


numLatitudesInterp = sum(latitudes>=latitudeCutoff);
betaInterp = betaOpt+repmat([-20:1:20]',1, numLatitudesInterp);
numBetasInterp = length(betaInterp);
betaOptMat = repmat(betaOpt, numBetasInterp, 1);

maxITmAMat = repmat(maxITmA(latitudes>=latitudeCutoff,1)', numBetasInterp, 1);
latitudeInterp = repmat(latitudes(latitudes>=latitudeCutoff), numBetasInterp,1);

%ITmAinterp = zeros(numLatitudesInterp, numBetasInterp);
[X, Y] = meshgrid(latitudes,betas);

ITmAinterp = interp2(X, Y, rb.ITmA', latitudeInterp, betaInterp);

figure(2);
clf;
contourf(latitudeInterp,betaInterp-betaOptMat, ITmAinterp./maxITmAMat, 200, 'LineStyle', 'none');
colorbar();
hold on;
[C, h] = contour(latitudeInterp,betaInterp-betaOptMat, ITmAinterp./maxITmAMat, [.95 .96 .97 .98 .99 1], 'linecolor', 'k', 'linewidth', 1, 'linestyle', '-');
clabel(C,h, 'FontSize',18,'Color','k', 'LabelSpacing',400)

figure(3);
clf;
x = mean(betaInterp-betaOptMat, 2);
y = mean(ITmAinterp./maxITmAMat, 2);
plot(x, y, 'b');
fraction10 = mean(interp1(x, y, [-10 10]));
fraction20 = mean(interp1(x, y, [-20 20]));
xlabel('Tilt Misalignment (Degrees)');
ylabel('Normalized Annual Insolation');

% for i = 1:numLatitudesInterp
%   %betaInterp = betaOpt(i)+[-20:1:20];
%   ITmAinterp(i,:) = interp1(rb.Betas, rb.ITmA(i, :), betaInterp(i, :));
% end