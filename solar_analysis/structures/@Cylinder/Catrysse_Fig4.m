clear;
omega_p = 1.37e16;
lambda_p = 138; % nm
omega_p = Photon.convert_wavelength_to_angular_frequency(lambda_p);
k_p = Photon.convert_wavelength_to_wavenumber(lambda_p);

%k_p = Photon.convert_angular_frequency_to_wavenumber(omega_p); %this is in 1/nm


omega_tau = 0; % rad/sec, lossless

nus = 1;
epsilon1 = 1; % air

radius = 120; % this is in nm

% cylinder is air;
ma = MaterialType.create('Air');

maxAngularFrequency = 0.7*omega_p;
minAngularFrequencyModes = 0.1*omega_p;
angularFrequency = linspace(0, maxAngularFrequency); 


ma.OpticalProperties = OpticalProperties.create_constant_epsilon(epsilon1, 0, angularFrequency);
cy(1) = Cylinder(ma, radius);
op1 = ma.OpticalProperties;

% outside is the metal
ma2 = MaterialType.create('Air');
ma2.OpticalProperties = OpticalProperties.create_Drude(omega_p,angularFrequency);
cy(2) = Cylinder(ma2, radius);
op2 = ma2.OpticalProperties



%betaArray = linspace(0, 2.4)*k_p;
betaArray = 0;
%betaArray = linspace(0,0.7*k_p, 30);
%betaArray = [0 0.1*k_p];
%[lambdaResonancesTE] = cy.calculate_waveguide_modes(betaArray, 'leakyTE');
%[lambdaResonancesTM] = cy.calculate_waveguide_modes(betaArray, 'leakyTM');


op1.truncate_spectrum_angular_frequency(minAngularFrequencyModes, maxAngularFrequency);
op2.truncate_spectrum_angular_frequency(minAngularFrequencyModes, maxAngularFrequency);
lambdaResonances = cy.calculate_waveguide_modes(betaArray, 'leaky', nus);
omegaResonances = Photon.convert_wavelength_to_angular_frequency(lambdaResonances);

figure(1);
clf;
[beta1] = op1.calc_light_line();
[beta2] = op2.calc_light_line();
plot(real(beta1)/k_p,op1.AngularFrequency/omega_p, 'b--')
hold on;
plot(real(beta2)/k_p,op2.AngularFrequency/omega_p, 'r-')
axis([0 0.7 0 0.7]);



for i = 1:length(betaArray)  
  for j = 1:size(omegaResonances, 1)
    for k = 1:size(omegaResonances, 2)
        plot(betaArray(i)/k_p, real(omegaResonances(j, k, i))/omega_p, 'ko');
    end
  end
end