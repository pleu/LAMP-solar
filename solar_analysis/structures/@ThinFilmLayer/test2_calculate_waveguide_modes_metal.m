clear;
thickness = 300;

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
%tf = ThinFilmLayer(ma, thickness);
tf = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes(tf);


ma1 = MaterialType.create('Air');
ma1.OpticalProperties = OpticalProperties('Air');
tf1(1) = ThinFilmLayer(ma1, thickness);
tf1(2) = ThinFilmLayer(ma, thickness);

%lambdaResonances = calculate_leaky_modes(tf);


betaArrayTE = linspace(0, 0.03, 100);

lambdaResonancesTE = calculate_waveguide_modes(tf1, betaArrayTE, 'TE');
 
pitchTE = 2*pi./betaArrayTE;
% 
% 
% axis([300 1100 150 400])
% 
save('lambdaResonancesTE', 'pitchTE', 'lambdaResonancesTE')



%axis([150 400 300 1100])

betaArrayTM = linspace(0, 0.03, 100);
pitchTM = 2*pi./betaArrayTM;
lambdaResonancesTM = calculate_waveguide_modes(tf1, betaArrayTM, 'TM');
%lambdaResonancesTM = calculate_waveguide_modes(tf1, betaArrayTM, 'TM');


%figure(2)

figure(1)
clf;
plot(lambdaResonancesTE, pitchTE, 'b--')
hold on;
%plot(lambdaResonancesTE, pitchTE, 'g--')

%plot(lambdaResonancesTMMetal, pitchTM, 'b:')
hold on;
plot(lambdaResonancesTM, pitchTM, 'g:')
xlabel('Pitch');
ylabel('Wavelength'); 


axis([300 1100 150 2200])

save('lambdaResonancesTM', 'pitchTM', 'lambdaResonancesTM')


% betaArrayT = linspace(0, 0.05, 100);
% lambdaResonancesT = calculate_waveguide_modes_between_metal(tf, betaArrayT);
% pitchT = 2*pi./betaArrayT;
% 
% plot(lambdaResonancesT, pitchT, 'k:')


figure(2)
clf;
plot(betaArrayTE, lambdaResonancesTE, 'b--')
hold on;
%plot(betaArrayTE, Photon.ConvertWavelengthToEnergy(lambdaResonancesTE), 'g--')

plot(betaArrayTM, lambdaResonancesTM, 'b:')

xlabel('Beta');
ylabel('Wavelength (nm)')
axis([min(betaArrayTE) max(betaArrayTM) 0 2500])
