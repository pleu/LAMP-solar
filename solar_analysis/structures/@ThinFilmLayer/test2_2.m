thickness = 100;
% 
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
% lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE');
% 
% 

ma = MaterialType.create('Si');
ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf1(2) = ThinFilmLayer(ma, thickness);
ma1 = MaterialType.create('Air');
%ma1.OpticalProperties = OpticalProperties('Si3N4 (FDTD)');

tf1(1) = ThinFilmLayer(ma1, thickness);

lambdaResonancesMetal = calculate_leaky_modes_on_metal(tf1);


betaArrayTE = linspace(0, 0.05, 100);
lambdaResonancesTEMetal = calculate_waveguide_modes_on_metal(tf1, betaArrayTE, 'TE');

betaArrayTM = linspace(0, 0.05, 200);
lambdaResonancesTMMetal = calculate_waveguide_modes_on_metal(tf1, betaArrayTM, 'TM');


%betaArray = linspace(0, 0.08);

% betaArrayTE = linspace(0, 0.05, 100);
% 
% lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE');
% 
pitchTE = 2*pi./betaArrayTE;
pitchTM = 2*pi./betaArrayTM;

% % 
figure(1)
clf;
%plot(real(lambdaResonancesTE), pitchTE, 'b')

% hold on;
plot(real(lambdaResonancesTEMetal), pitchTE, 'g')
hold on;
plot(real(lambdaResonancesTMMetal), pitchTM, 'b')
axis([300 1100 150 500])

figure(2)
clf;
plot(betaArrayTE, real(lambdaResonancesTEMetal), 'g')
hold on;
plot(betaArrayTM, real(lambdaResonancesTMMetal), 'b')

%lambdaResonancesCheck = calculate_waveguide_modes(tf, betaArray, 'TE');


% 
% 
% 
% 
% 



%betaArray = linspace(0, 0.08, 1000);
%lambdaResonancesCheck = calculate_waveguide_modes(tf, betaArray, 'TM');

%lambdaRange = linspace(300, 1200);

%lambdaRange = 300;

%[beta] = calculate_waveguide_modes_from_lambda2(tf, lambdaRange, 'TE')

