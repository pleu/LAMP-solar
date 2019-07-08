clear;
% This reproduces Figure 3 on page 30 of Joannopoulos, Photonic Crystals
thickness = 50;

ma = MaterialType.create('Air');
tf(1) = ThinFilmLayer(ma, thickness);

epsilon = 11.4;
ma1 = MaterialType.create('Air');
ma1.OpticalProperties = OpticalProperties.create_constant_index(sqrt(epsilon));
ma1.OpticalProperties.Wavelength(1) = 33;
%ma.OpticalProperties.K = zeros(length(ma.OpticalProperties.Wavelength), 1);
tf(2) = ThinFilmLayer(ma1, thickness);

betaArrayTE = linspace(0, 0.6, 30);
%betaArrayTE = 0;
lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE', 'leaky');

betaArrayTM = linspace(0, 0.6, 30);
lambdaResonancesTM = calculate_waveguide_modes(tf, betaArrayTE, 'TM', 'leaky');




% energy
figure(1);
clf;
%plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b:')
plot(betaArrayTE, real(2*pi./lambdaResonancesTE), 'bo')
hold on;
plot(betaArrayTM, real(2*pi./lambdaResonancesTM), 'go')

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
plot(betaArrayTE, Photon.convert_wavelength_to_energy(real(lambdaResonancesTE)), 'bo')
hold on;
plot(betaArrayTM, Photon.convert_wavelength_to_energy(real(lambdaResonancesTM)), 'go')

plot(beta1, Photon.ConvertWavelengthToEnergy(2*pi./kTry), 'g--');
plot(beta2, Photon.ConvertWavelengthToEnergy(2*pi./kTry), 'g-.');
%axis([0 0.08 1.0 3.1])

ylabel('Energy (eV)');
xlabel('Beta (1/nm)');

figure(3);
clf;
% normalize the units
plot(betaArrayTE*thickness/(2*pi), Photon.convert_wavelength_to_angular_frequency(real(lambdaResonancesTE))*thickness/(2*pi*Constants.LightConstants.C*Constants.UnitConversions.MtoNM), 'bo')
hold on;
plot(betaArrayTM*thickness/(2*pi), Photon.convert_wavelength_to_angular_frequency(real(lambdaResonancesTM))*thickness/(2*pi*Constants.LightConstants.C*Constants.UnitConversions.MtoNM), 'go')

plot(beta1*thickness/(2*pi), Photon.convert_wavenumber_to_angular_frequency(kTry)*thickness/(2*pi*Constants.LightConstants.C*Constants.UnitConversions.MtoNM), 'k--');
hold on;
plot(beta2*thickness/(2*pi), Photon.convert_wavenumber_to_angular_frequency(kTry)*thickness/(2*pi*Constants.LightConstants.C*Constants.UnitConversions.MtoNM), 'k-.');

xlabel('Parallel wave vector (ka/2\pi)');
ylabel('Frequency (\omega a/2\pi c)');
axis([0 4 0 1.5]);

