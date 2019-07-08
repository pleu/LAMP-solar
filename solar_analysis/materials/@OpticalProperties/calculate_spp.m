function [lambdaMatrix] = calculate_spp(tf)
%CALCULATE_SPP Summary of this function goes here
%   Detailed explanation goes here

if length(tf)~=2
  error('The size of ThinFilmLayer should be 2');
end

op1 = tf(1).MaterialData.OpticalProperties;
op2 = tf(2).MaterialData.OpticalProperties;

numLambda = 10000;
lambda = linspace(300, 4000, numLambda)'; % in nm

k = [2*pi./lambda zeros(length(lambda), 1)]; % in 1/nm

maxM = 3;

for m = 1:maxM
  eqn = ThinFilmLayer.spp(k, m, pitch, op1, op2);
  
  indReal = find(abs(eqn(:, 1)) < 0.01);
  %  kGuess = k(indReal);
  kGuess = k([indReal(diff(indReal) ~= 1); max(indReal)], 1);
  
  if ~isempty(kGuess)
    f = @(x) spp(x, m, pitch, op1, op2);
    resonances = fsolve(f, [kGuess, 0], options);
    resonancesComplex = complex(resonances(1), resonances(2));
    lambdaMatrix(m, ind) = 2*pi./resonancesComplex;
  end
end
