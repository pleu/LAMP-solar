function [angularFrequency, beta] = calc_spp_dispersion(op, angularFrequency)
% calculates beta in units of 1/nm
if numel(op)~=2
  error('There should be two materials in optical properties array');
end
if nargin == 1
  angularFrequency = op(1).AngularFrequency;
end

%angularFrequency = Photon.convert_wavelength_to_angular_frequency(wavelength);

epsilon2Real = interp1(op(2).AngularFrequency, op(2).Epsilon1, angularFrequency);
epsilon2Imag = interp1(op(2).AngularFrequency, op(2).Epsilon2, angularFrequency);

epsilon1 = op(1).Epsilon1+1i*op(1).Epsilon2;
epsilon2 = epsilon2Real + 1i*epsilon2Imag;

beta =  angularFrequency/Constants.LightConstants.Cnm.*...
  sqrt(epsilon1.*epsilon2./(epsilon1+epsilon2));    % units of 1/nm

%angularFrequency = op(1).AngularFrequency;