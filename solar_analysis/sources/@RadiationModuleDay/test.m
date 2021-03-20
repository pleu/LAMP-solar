clear;
latitudes = [20 40]; % latitude in degrees
days = linspace(0, 365);

rb = RadiationBeamDay(latitudes, days);

betas = linspace(0, 80, 81);
gamma = 0;

mo = Module(betas,gamma);


rm = RadiationModuleDay(mo, rb);
rm.calculate_daily_module_insolation;