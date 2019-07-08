clear;
thickness = 100;

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes_between_metal(tf);

betaArrayT = linspace(0, 0.05, 100);

lambdaResonancesT = calculate_waveguide_modes_between_metal(tf, betaArrayT);


figure(2)
clf;
plot(betaArrayT, Photon.ConvertWavelengthToEnergy(lambdaResonancesT), 'b')
axis([0 0.05 0 3])
hold on;


pitchT = 2*pi./betaArrayT;
% 
figure(3)
clf;
plot(real(lambdaResonancesT), pitchT, 'b')
axis([300 1100 150 400])
