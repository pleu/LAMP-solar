clear;
thickness = 100;


ma1 = MaterialType.create('Air');
ma1.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');

ma2 = MaterialType.create('Si');
ma2.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');

%ma2.OpticalProperties = OpticalProperties('Si3N4 (FDTD)');

tf(1) = ThinFilmLayer(ma1, thickness);
tf(2) = ThinFilmLayer(ma2, thickness);

%tf = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes_on_metal(tf);


betaArrayTE = linspace(0, 0.05, 100);
% 
lambdaResonancesTEMetal = calculate_waveguide_modes_on_metal(tf, betaArrayTE, 'TE');

pitchTE = 2*pi./betaArrayTE;
%betaArrayTE = 2*pi./pitchTE;
mo = Modes('TEMetal', lambdaResonancesTEMetal, pitchTE);

mo.plot([], [], 'Color', 'k' ,'LineStyle', ':')
rgb = [0.3 0.3 0.3];
factors = [sqrt(4/3) 2 sqrt(16/3) sqrt(28/3)];
mo.plot([], factors, 'Color', rgb ,'LineStyle', ':')
axis([200 2000 300 1200]);

save('lambdaResonancesTE', mo);