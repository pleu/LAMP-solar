function [lambdaResonances] = calculate_spp_modes(op, rhs, kGuess)
% given rhs which is beta, solves for lambda

if nargin== 2 || isnan(kGuess)
  numLambda = 10000;
  lambda = linspace(300, 1200, numLambda)';
  
  %op = tf.MaterialData.OpticalProperties;
  k = [2*pi./lambda zeros(length(lambda), 1)];
  
  eqn = OpticalProperties.spp(k, op(1), op(2), rhs);
  
  %indReal = find(eqn(:, 1) < -0.1);
  [xmax, imax, xmin, indReal] = extrema(eqn(:, 1));
  %indConsReal = find(diff(indReal) ~= 1);
  
  %kGuess = k([indReal(diff(indReal) ~= 1); max(indReal)], 1);
  %[kGuess, ind] = min(abs(eqn(:, 1)));
  kGuess = k([indReal(diff(indReal) ~= 1); max(indReal)], 1);
  
  %kGuess = k(ind);
  %resonances = zeros(size(kGuess, 1), 2);
end
kGuess = unique(kGuess);

lambdaResonances = zeros(size(kGuess, 1), 1);

options = optimset('Display', 'iter', 'MaxIter', 1e4, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);
if isempty(kGuess)
  lambdaResonances = NaN;
else
  for m = 1:length(kGuess)
    f = @(x) OpticalProperties.spp(x,op(1),op(2),rhs);
    [resonances, fVal, exitFlag] = fsolve(f, [kGuess(m), 0], options);
    if exitFlag == 1
      resonancesComplex = complex(resonances(1), resonances(2));
      lambdaResonances(m, 1) = 2*pi./resonancesComplex;
    else
      lambdaResonances(m, 1) = nan;
    end
  end
  %   for m = 1:length(kGuess)
  %     f = @(x) OpticalProperties.spp(x,op(1),op(2),rhs);
  %     resonances(m, :) = fsolve(f, [kGuess(m), 0], options);
  %     resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
  %     lambdaResonances(m, 1) = 2*pi./resonancesComplex;
  %   end
end
lambdaResonances = max(lambdaResonances);


