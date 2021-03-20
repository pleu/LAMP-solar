clear;
latitudes = [20 40]; % latitude in degrees
days = linspace(0, 365);

rb = RadiationBeam(latitudes, days);

figure(1);
clf;
plot(days, rb.ITD);