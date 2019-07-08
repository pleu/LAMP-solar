
% ma = MaterialType.create('SiO2');
% ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');
% clear;
% 
% op1 = OpticalProperties('Air');
% op2 = OpticalProperties('Si (Silicon) - Palik (FDTD)');
% beta = 0;
% k = [1.3207e+07 0];
% ThinFilmLayer.symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
% ThinFilmLayer.antisymmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
% 
% ThinFilmLayer.leaky_resonance_mode_2d_even(k, op2, thickness)


thickness = 50;

ma = MaterialType.create('Air');
ma.OpticalProperties = OpticalProperties('Air');


%ma = MaterialType.create('SiO2');
%ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');

%ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf(1) = ThinFilmLayer(ma, thickness);

ma = MaterialType.create('Si');

ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf(2) = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes(tf);

%betaArray = 0.02;

%betaArray = 0;


% 
% op1 = tf(1).MaterialData.OpticalProperties;
% op2 = tf(2).MaterialData.OpticalProperties;
% 
% betaTest = 0.0327;
% k = [2*pi./(op2.Wavelength*1e-9) zeros(length(op2.Wavelength), 1)];
%f = ThinFilmLayer.waveguide_mode_TE(k,betaTest*1e9,op1,op2,thickness*1e-9);


betaArrayTE = linspace(0, 0.08, 100);
lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE');
% 
% 
% 
% 
% 

betaArrayTM = linspace(0, 0.08, 200);
lambdaResonancesTM = calculate_waveguide_modes(tf, betaArrayTM, 'TM');


% 
% 
figure(1);
clf;
plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b')
hold on;
axis([0 0.08 1.0 3.1])

figure(2);
clf;
hold on;
plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'g')
axis([0 0.08 1.0 3.1])

% % 
for n = 2:2:6
  figure(1);
  plot(betaArrayTE./n, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b:')
  figure(2);
  plot(betaArrayTM./n, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'g:')
end

figure(3);
clf;
pitchTE = 2*pi./betaArrayTE;
plot(pitchTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b')
hold on;
axis([80 640 1.0 3.1])

figure(4);
clf;
pitchTM = 2*pi./betaArrayTM;
plot(pitchTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'g')
hold on;
axis([80 640 1.0 3.1])


for n = 2:2:6
  figure(3);
  betaArrayTECurrent = betaArrayTE./n;
  pitchTE = 2*pi./betaArrayTECurrent;  
  plot(pitchTE, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTE)), 'b:')
  
  
  
  figure(4);
  betaArrayTMCurrent = betaArrayTM./n;
  pitchTM = 2*pi./betaArrayTMCurrent;  
  plot(pitchTM, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'g:')
  %figure(2);
  %plot(betaArrayTM./n, Photon.ConvertWavelengthToEnergy(real(lambdaResonancesTM)), 'g:')
end








axis([0 0.08 1 3.1])
% % 
%figure(2);
%clf;
%
%axis([0 0.08 1 3.1])


%maxBeta = 0.02;
%betaArray = linspace(0, maxBeta)';
%betaArray = 0;
%lambdaResonances = tf.calculate_waveguide_modes(betaArray, 'TE')

% lambdaResonances
% figure(1);
% clf;
% plot(betaArray, lambdaResonances);


