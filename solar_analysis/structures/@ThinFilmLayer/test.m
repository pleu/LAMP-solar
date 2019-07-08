thickness = 100;

ma = MaterialType.create('Ag');
ma.OpticalProperties = OpticalProperties('Ag');


%ma = MaterialType.create('SiO2');
%ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');

tf(1) = ThinFilmLayer(ma, thickness);

ma = MaterialType.create('Si');

ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
tf(2) = ThinFilmLayer(ma, thickness);

lambdaResonances = calculate_leaky_modes(tf);
betaArrayTE = linspace(0, 0.05, 100);

lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE');


lambdaResonancesTM = calculate_waveguide_modes(tf, betaArrayTE, 'TM');


% ma = MaterialType.create('Si');
% ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
% tf1 = ThinFilmLayer(ma, thickness);
%lambdaResonancesMetal = calculate_leaky_modes_on_metal(tf1);

%lambdaResonancesTEMetal = calculate_waveguide_modes_on_metal(tf1, betaArrayTE, 'TE');


%betaArray = linspace(0, 0.08);

% betaArrayTE = linspace(0, 0.05, 100);
% 
% lambdaResonancesTE = calculate_waveguide_modes(tf, betaArrayTE, 'TE');
% 
pitchTE = 2*pi./betaArrayTE;
% 
figure(1)
clf;
plot(real(lambdaResonancesTE), pitchTE, 'b')
axis([300 1100 150 400])
%hold on;
%plot(real(lambdaResonancesTEMetal), pitchTE, 'g')
hold on;
plot(real(lambdaResonancesTM), pitchTE, 'g')


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



