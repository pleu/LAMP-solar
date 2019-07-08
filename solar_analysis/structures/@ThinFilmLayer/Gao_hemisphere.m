clear;
thickness = 100;

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf = ThinFilmLayer(ma, thickness);

ma1 = MaterialType.create('Air');
ma1.OpticalProperties = OpticalProperties('Air');
tf(1) = ThinFilmLayer(ma1, thickness);

tf(2) = ThinFilmLayer(ma, thickness); 

%lambdaResonances = calculate_leaky_modes_on_metal(tf);


betaArrayTE = linspace(0, 0.08, 100);

lambdaResonancesTEMetal = calculate_waveguide_modes(tf, betaArrayTE, 'TE', 'leakyOnMetal');
%lambdaResonancesTEMetal = zeros(length(betaArrayTE), 0);
pitchTE = 2*pi./betaArrayTE;
% 
% 
% axis([300 1100 150 400])
% 
save('lambdaResonancesTE', 'pitchTE', 'lambdaResonancesTEMetal')



%axis([150 400 300 1100])

betaArrayTM = linspace(0, 0.08, 100);
%betaArrayTM = 0.05;
pitchTM = 2*pi./betaArrayTM;
lambdaResonancesTMMetal = calculate_waveguide_modes(tf, betaArrayTM, 'TM', 'leakyOnMetal');


%figure(2)

figure(1)
clf;
plot(lambdaResonancesTEMetal, pitchTE, 'bo')
hold on;
%plot(lambdaResonancesTE, pitchTE, 'g--')

plot(lambdaResonancesTMMetal, pitchTM, 'go')
hold on;
xlabel('Pitch');
ylabel('Wavelength'); 
%plot(lambdaResonancesTM, pitchTM, 'g:')

axis([300 1100 150 500])

save('lambdaResonancesTM', 'pitchTM', 'lambdaResonancesTMMetal')


% betaArrayT = linspace(0, 0.05, 100);
% lambdaResonancesT = calculate_waveguide_modes_between_metal(tf, betaArrayT);
% pitchT = 2*pi./betaArrayT;
% 
% plot(lambdaResonancesT, pitchT, 'k:')


figure(2)
clf;
plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(lambdaResonancesTEMetal), 'bo')
hold on;
%plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(lambdaResonancesTE), 'g--')

plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(lambdaResonancesTMMetal), 'go')

xlabel('Beta');
ylabel('Energy (eV)')
axis([0 0.05 0 3.5])


% energy
figure(3);
clf;
%plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b:')
plot(betaArrayTE, real(2*pi./lambdaResonancesTEMetal), 'bo')
hold on;

plot(betaArrayTE, real(2*pi./lambdaResonancesTMMetal), 'go')

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


%plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(lambdaResonancesTM), 'g:')

%plot(betaArrayT, Photon.ConvertWavelengthToEnergy(lambdaResonancesT), 'k:')

% save('lambdaResonancesBetweenMetal', 'pitchT', 'lambdaResonancesT')



% figure(4);
% clf;
% plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)))

%axis([0 400 300 1100])