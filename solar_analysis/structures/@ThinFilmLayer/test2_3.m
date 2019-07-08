clear;
thickness = 100;

% ma = MaterialType.create('Air');
% ma.OpticalProperties = OpticalProperties('Air');
% 
% 
% %ma = MaterialType.create('SiO2');
% %ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');
% 
% tf(1) = ThinFilmLayer(ma, thickness);
% 
% ma = MaterialType.create('Si');
% 
% ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
% tf(2) = ThinFilmLayer(ma, thickness);
% 
% lambdaResonances = calculate_leaky_modes(tf);
% 
% lambdaResonancesTM = calculate_waveguide_modes(tf, betaArrayTM, 'TM');
% 


ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf1 = ThinFilmLayer(ma, thickness);
% lambdaResonancesMetal = calculate_leaky_modes_on_metal(tf1);
% 
betaArrayTM = linspace(0, 0.05, 200);

lambdaResonancesTMMetal = calculate_waveguide_modes_on_metal(tf1, betaArrayTM, 'TM');
% 
%pitchTM = 2*pi./betaArrayTM;
%betaArray = linspace(0, 0.08);

betaArrayTE = linspace(0, 0.05, 100);
% 
lambdaResonancesTEMetal = calculate_waveguide_modes_on_metal(tf1, betaArrayTE, 'TE');
% 
% pitchTE = 2*pi./betaArrayTE;
% 
% figure(1)
% clf;
% plot(real(lambdaResonancesTM), pitchTM, 'b')
% axis([300 1100 150 400])
% hold on;
% plot(real(lambdaResonancesTMMetal), pitchTM, 'g')

% pitchTM = 2*pi./betaArrayTM;
% % 
% figure(1)
% clf;
% plot(real(lambdaResonancesTM), pitchTM, 'b')
% axis([300 1100 150 400])
% hold on;
% plot(real(lambdaResonancesTMMetal), pitchTM, 'g')

% 
% figure(2)
% clf;
% plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(lambdaResonancesTM), 'b')
% hold on;
% plot(betaArrayTM, Photon.ConvertWavelengthToEnergy(lambdaResonancesTMMetal), 'g')
% axis([0 0.05 0 3])
% hold on;

