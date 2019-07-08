clear;
thickness = 50;

ma = MaterialType.create('SiO2');
ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');
tf(1) = ThinFilmLayer(ma, thickness);

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
%ma.OpticalProperties.K = zeros(length(ma.OpticalProperties.Wavelength), 1);
tf(2) = ThinFilmLayer(ma, thickness);

% clear;
% thickness = 5000;
% 
% n1 = 1.5;
% ma1 = MaterialType.create('Air');
% minWavelength = 1500;
% maxWavelength = 4000;
% ma1.OpticalProperties = OpticalProperties.create_constant_index(n1);
% ma1.OpticalProperties.Wavelength(1) = minWavelength;
% ma1.OpticalProperties.Wavelength(2) = maxWavelength;
% %ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');
% tf(1) = ThinFilmLayer(ma1, thickness);
% 
% n2 = 1.6;
% ma = MaterialType.create('Air');
% ma.OpticalProperties = OpticalProperties.create_constant_index(n2);
% ma.OpticalProperties.Wavelength(1) = minWavelength;
% ma.OpticalProperties.Wavelength(2) = maxWavelength;
% tf(2) = ThinFilmLayer(ma, thickness);

betaArrayTE = linspace(0, 0.08, 100);
lambdaResonancesTE = calculate_waveguide_modes_Yariv(tf, betaArrayTE, 'TE');

betaArrayTM = linspace(0, 0.08, 100);
lambdaResonancesTM = calculate_waveguide_modes_Yariv(tf, betaArrayTE, 'TM');




% energy
figure(1);
clf;
%plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b:')
plot(betaArrayTE, real(2*pi./lambdaResonancesTE), 'bo')
plot(betaArrayTE, real(2*pi./lambdaResonancesTM), 'go')

hold on;
xlabel('Beta')
ylabel('k (1/nm)');


op1 = tf(1).Material.OpticalProperties;
op2 = tf(2).Material.OpticalProperties;


kGuessMax = min(2*pi./(min(op1.Wavelength)), 2*pi./(min(op2.Wavelength)));
kGuessMin = max(2*pi./(max(op1.Wavelength)), 2*pi./(max(op2.Wavelength)));

kTry = linspace(kGuessMin, kGuessMax, 1000);

n1 = interp1(op1.Wavelength, op1.N, 2*pi./kTry);
n2 = interp1(op2.Wavelength, op2.N, 2*pi./kTry);



beta1 = n1.*kTry;
beta2 = n2.*kTry;
hold on;
plot(beta1, kTry, 'g--');
plot(beta2, kTry, 'g-.');
%betaLower = 
%axis([0 0.02 1e-3 5e-3])

figure(2);
clf;
plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'bo')
hold on;
plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'go')

plot(beta1, Photon.ConvertWavelengthToEnergy(2*pi./kTry), 'g--');
plot(beta2, Photon.ConvertWavelengthToEnergy(2*pi./kTry), 'g-.');
axis([0 0.08 1.0 3.1])

