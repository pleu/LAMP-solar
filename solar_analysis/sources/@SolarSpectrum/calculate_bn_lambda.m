function bnLambda = calculate_bn_lambda(lambda, n, temperature, F)
%CALCULATE_BN 
% Equation 2.12 in Nelson, Physics of Solar Cells
% Calculates the emitted photon flux density (in 
% # of photons/m^2*sec^(-1)*nm^-1)
% 
% Copyright 2021
% Paul Leu
% LAMP, University of Pittsburgh
  bnLambda = Constants.LightConstants.C*n.^2.*F.*2./(lambda.^4)./(exp(Constants.LightConstants.Hbar.*2.*pi.*Constants.LightConstants.C./ ...
    (lambda.*Constants.LightConstants.k_B*temperature)*Constants.UnitConversions.NMperM)-1).*Constants.UnitConversions.NMperM.^3;
% in W/(m^2*eV)
end

