function be = calculate_be_omega(energy, delMu, temperature)
% CALCULATE_BE_OMEGA 
% Equation 2.14 in Nelson, Physics of Solar Cells without geometrical
    % factor
% Calculates the emitted photon flux density (in 
% # of photons/m^2*sec^(-1)*eV^-1)
% E is in eV
% 
% See also
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  be = 2/...
    (Constants.LightConstants.H^3* ...
    Constants.LightConstants.C^2)*(energy.^2)./(exp((energy-delMu)./ ...
    (Constants.LightConstants.k_B*temperature))-1);
% in W/(m^2*eV)
end

