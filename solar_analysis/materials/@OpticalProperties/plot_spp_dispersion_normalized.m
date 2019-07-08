function [] = plot_spp_dispersion_normalized(op, varargin)

if numel(op)~=2
  error('There should be two materials in optical properties array');
end

%minAngularFrequency = max([min(op(1).AngularFrequency) min(op(2).AngularFrequency)]);
%maxAngularFrequency = max([min(op(1).AngularFrequency) min(op(2).AngularFrequency)]);

epsilon2Real = interp1(op(2).AngularFrequency, op(2).Epsilon1, op(1).AngularFrequency);
epsilon2Imag = interp1(op(2).AngularFrequency, op(2).Epsilon2, op(1).AngularFrequency);

epsilon1 = op(1).Epsilon1+1i*op(1).Epsilon2;
epsilon2 = epsilon2Real + 1i*epsilon2Imag;

beta = op(1).AngularFrequency.*...
  sqrt(epsilon1.*epsilon2./(epsilon1+epsilon2));

optionplot(real(beta), op(1).AngularFrequency, varargin{:});


