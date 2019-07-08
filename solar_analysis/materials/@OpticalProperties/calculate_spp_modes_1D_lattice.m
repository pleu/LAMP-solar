function [lambdaResonances] = calculate_spp_modes_1D_lattice(op, a, kGuess)

if nargin < 3
  kGuess = nan;
end

mMax = 4;
%nMax = 3;

lambdaResonances = zeros(mMax+1, 1);
rhsMat = zeros(mMax+1, 1);

%a
for m = 0:mMax
  %for n = 0:nMax
    %rhsMat(m+1, n+1) = 2*pi/a*sqrt(4/3*m^2+n^2-2*sqrt(3)/3*m*n);
    rhsMat(m+1) = 2*pi/a*sqrt(m^2);
    rhs = rhsMat(m+1);
    if isnan(kGuess)
      %       m
      %       n
      lambdaResonances(m+1) = calculate_spp_modes(op, rhs);
    else
      %       m
      %       n
      lambdaResonances(m+1) = calculate_spp_modes(op, rhs, real(kGuess(m+1)));
    end
  %end
end

