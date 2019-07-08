diameter = 200:100:1500;
ma = MaterialType.create('SiO2');
ma.OpticalProperties = OpticalProperties('SiO2 (Glass) - Palik (FDTD)');

% refractiveIndex = 1.46;
% 
% ma = MaterialType.create('Air');
% ma.OpticalProperties = OpticalProperties.create_constant_index(refractiveIndex);
% 
% ma.OpticalProperties.Wavelength(1) = 200;
% ma.OpticalProperties.Wavelength(2) = 2000;
% 
ns = Nanosphere(ma, diameter);

%lambdaResonancesTM = ns.calculate_modes('TM');

%lambdaResonancesTE = ns.calculate_modes('TE');
%lambdaResonancesTM = ns.calculate_modes('TM');

figure(1);
clf;

lambdaResonancesTM = ns.plot_modes('TM', 'Color', 'b');
hold on;

lambdaResonancesTE = ns.plot_modes('TE', 'Color', 'g');
moTM = Modes('TM', lambdaResonancesTM, diameter);

moTE = Modes('TE', lambdaResonancesTE, diameter);

moTM.plot([1 1], [1 2 3], 'Color', 'b')

moTE.plot([1 2], [1 2 3], 'Color', 'g')

axis([200 2000 300 1200]);