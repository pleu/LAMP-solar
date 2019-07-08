clear;
radius = 110;

ma = MaterialType.create('Ge');
cy(1) = Cylinder(ma, radius);

ma = MaterialType.create('Air');
cy(2) = Cylinder(ma, radius);

betaArray = 0;

%[lambdaResonances] = cy.calculate_waveguide_modes(betaArray, 'leaky');
%[lambdaResonancesTE] = cy.calculate_waveguide_modes(betaArray, 'leakyTE');
% Seems to miss the TE_11 mode at 605 nm; not sure if this is the error on
% algorithm or Linyou's paper

%[lambdaResonancesTM] = cy.calculate_waveguide_modes(betaArray, 'leakyTM');
% Gets all the TM modes

waveguideModes = cy.calculate_waveguide_modes(betaArray, 'leaky');