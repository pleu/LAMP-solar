function [beta, k_z, L, z_hat, z_1, z_2] = calc_spp_wavevector_from_wavelength(op, wavelength)
% wavelength should be in nm
% beta (1/nm), k_z (1/nm), L (nm), z_hat (nm)
if numel(op)~=2
  error('There should be two materials in optical properties array');
end

angularFrequency = Photon.convert_wavelength_to_angular_frequency(wavelength);

epsilon2Real = interp1(op(2).AngularFrequency, op(2).Epsilon1, angularFrequency);
epsilon2Imag = interp1(op(2).AngularFrequency, op(2).Epsilon2, angularFrequency);

epsilon1Real = interp1(op(1).AngularFrequency, op(1).Epsilon1, angularFrequency);
epsilon1Imag = interp1(op(1).AngularFrequency, op(1).Epsilon2, angularFrequency);

epsilon1 = epsilon1Real + 1i*epsilon1Imag;
epsilon2 = epsilon2Real + 1i*epsilon2Imag;

beta = angularFrequency./Constants.LightConstants.C.*...
  sqrt(epsilon1.*epsilon2./(epsilon1+epsilon2))/Constants.UnitConversions.MtoNM;   % units of 1/meters
L = 1./(2*imag(beta)); % in nm

k_z = sqrt(beta.^2 - epsilon2.*(angularFrequency/(Constants.LightConstants.C*Constants.UnitConversions.MtoNM)).^2);
z_hat = 1./real(k_z); % this is the same as z_2

% metal skin depth; epsilon1 must be metal
z_1 = (wavelength/(2*pi)).*abs(((epsilon1+epsilon2)./(epsilon1).^2).^0.5)
% semiconductor skin depth
z_2 = (wavelength/(2*pi)).*abs(((epsilon1+epsilon2)./(epsilon2).^2).^0.5)

%z_hat = 1/k_z;

