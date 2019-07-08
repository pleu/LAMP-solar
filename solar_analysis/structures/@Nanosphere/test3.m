diameter = 400;
refractiveIndex = 4;
%ma = MaterialType.create('SiO2');

ma = MaterialType.create('Air');
ma.OpticalProperties = OpticalProperties.create_constant_index(refractiveIndex);

ma.OpticalProperties.Wavelength(1) = 200;
ma.OpticalProperties.Wavelength(2) = 2000;

ns = Nanosphere(ma, diameter);

%lambdaResonancesTM = ns.calculate_modes('TM');

%lambdaResonancesTE = ns.calculate_modes('TE');
lambdaResonancesTM = ns.calculate_waveguide_modes('TM');