%a = 1500;
a = 1300;
op(1) = OpticalProperties('Ag (Silver) - Johnson and Christy (raw)');
%op(1) = OpticalProperties('Cu (Copper) - CRC (FDTD)');
op(2) = OpticalProperties('air');

mMax = 3;
nMax = 3;

lambdaResonances = zeros(2*mMax+1, 2*nMax+1);
rhsMat = zeros(2*mMax+1, 2*nMax+1);

for m = -mMax:mMax
  for n = -nMax:nMax
    rhsMat(m+mMax+1, n+nMax+1) = 2*pi/a*sqrt(4/3*(m^2+n^2-m*n));
    %rhs = 2*pi/a*sqrt(m^2+n^2);
    rhs = rhsMat(m+mMax+1, n+nMax+1);
    lambdaResonances(m+mMax+1, n+nMax+1) = calculate_spp_modes(op, rhs);
  end
end

rhsMat
lambdaResonances

lambdaResonancesVec = [447.1 599.1 672.9];
labels = {'(3, 2), (3, 1), (2, 3), or (1, 3)', '(2, 0), (2, 2), or (0, 2)',...
  '(2, 1) or (1, 2)'};

for i = 1:length(lambdaResonancesVec)
  plot([lambdaResonancesVec(i) lambdaResonancesVec(i)], [0.4 0.5], 'g--');
  hold on;
end