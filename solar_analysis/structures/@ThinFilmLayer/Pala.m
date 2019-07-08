% Pala results
% http://onlinelibrary.wiley.com/doi/10.1002/adma.200900331/abstract

clear;
thickness = 50;

ma = MaterialType.create('SiO2');
ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');
tf(1) = ThinFilmLayer(ma, thickness);

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
%ma.OpticalProperties.K = zeros(length(ma.OpticalProperties.Wavelength), 1);
tf(2) = ThinFilmLayer(ma, thickness);

%lambdaResonances = calculate_leaky_modes(tf);

betaArrayTE = linspace(0, 0.08, 100);
%betaArrayTE = linspace(0, 0.08, 100);

[lambdaResonancesTE] = calculate_waveguide_modes(tf, betaArrayTE, 'TE', 'guided');
%lambdaResonancesTE = zeros(length(betaArrayTE), 1);


betaArrayTM = linspace(0, 0.08, 100);
[lambdaResonancesTM] = calculate_waveguide_modes(tf, betaArrayTM, 'TM', 'guided');
%lambdaResonancesTM = zeros(length(betaArrayTM), 1);

figure(1);
clf;
lambdaResonancesTE = sort(lambdaResonancesTE, 1);
plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'bo')
hold on;
plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'go')
% 
% figure(2);
% clf;
% lambdaResonancesTE = sort(lambdaResonancesTE, 1);
% plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTEComplex)), 'bo')
% hold on;
% plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTMComplex)), 'go')


%hold on;
axis([0 0.08 1.0 3.1])
xlabel('Beta (1/nm)');
ylabel('Energy (eV)');


