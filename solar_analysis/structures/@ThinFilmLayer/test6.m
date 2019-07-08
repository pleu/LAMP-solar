thickness = 300;

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf = ThinFilmLayer(ma, thickness);

%lambdaResonances = calculate_leaky_modes_between_metal(tf);
lambdaResonances = calculate_leaky_modes(tf);
%lambdaResonances_on_metal = calculate_leaky_modes_on_metal(tf);

%betaArray = linspace(0, 0.04);
%lambdaResonancesCheck = calculate_waveguide_modes_between_metal(tf, betaArray);

% figure(2);
% clf;
% pitch = 2*pi./betaArraye
% plot(lambdaResonancesCheck, pitch);

axis([300 1100 170 400])