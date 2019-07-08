function bn = calculate_bn(energy, n, delMu, temperature, F)
%CALCULATE_BN 
% Equation 2.12 in Nelson, Physics of Solar Cells
% Calculates the emitted photon flux density (in 
% # of photons/m^2*sec^(-1)*eV^-1)
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  bn = 2.*n.^2.*F./...
    (Constants.LightConstants.H^3* ...
    Constants.LightConstants.C^2).*(energy.^2)./(exp((energy-delMu)./ ...
    (Constants.LightConstants.k_B*temperature))-1);
% in W/(m^2*eV)
end

