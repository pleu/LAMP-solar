function [lambdaResonances] = calculate_assymetric_waveguide_modes(tf, betaArray, TEorTM)
% tf must be at least three layers
% tf(1) is the top layer
% tf(2) is the middle or waveguiding layer
% tf(3) is the bottom layer

op = tf.MaterialData.OpticalProperties;

% most resonances should be at beta = 0

[lambdaResonances] = calculate_leaky_modes(tf);

kGuess = 2*pi./lambdaResonances;

maxK = size(kGuess, 1);
% 
lambdaResonances = zeros(maxK, length(betaArray));
resonances = zeros(maxK, 2);

options = optimset('Display', 'iter', 'MaxIter', 1e4, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);
%ThinFilmLayer.leaky_resonance_mode_2d([real(kGuess) imag(kGuess)], op, tf.Thickness)
for ind = 1:length(betaArray)
  beta = betaArray(ind);
  %   if strncmp(TEorTM, 'TE', 2)
  %     eqn = ThinFilmLayer.waveguide_mode_TE(k,beta,op,tf.Thickness);
  %   else
  %     eqn = ThinFilmLayer.waveguide_mode_TM(k,beta, op,tf.Thickness);
  %   end
  %   indReal = find(eqn(:, 1) < -0.1);
  %   %indConsReal = find(diff(indReal) ~= 1);
  %   kGuess = k([indReal(diff(indReal) ~= 1); max(indReal)], 1);
  %
  %if ind ~= 1
    %kGuess = 
  %end
  if ind ~= 1
    kGuess = resonances;
  end
  for m = 1:length(kGuess)
    %resonances(m, 1)
    if strncmp(TEorTM, 'TE', 2)
      %f = @(x) ThinFilmLayer.leaky_resonance_mode_2d(x,op,tf.Thickness);
      f = @(x) ThinFilmLayer.waveguide_mode_TE(x,beta,op,tf.Thickness);
      %      eqn = ThinFilmLayer.waveguide_mode_TE([kGuess(m) 0],beta,op,tf.Thickness);
    else
      f = @(x) ThinFilmLayer.waveguide_mode_TM(x,beta,op,tf.Thickness);
      %eqn = ThinFilmLayer.waveguide_mode_TM([kGuess(m) 0],beta, op,tf.Thickness);
    end
    %indReal = find(eqn(:, 1) < -0.1);
    

    resonances(m, :) = fsolve(f, [real(kGuess(m)), imag(kGuess(m))], options);
    resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
    lambdaResonances(m, ind) = 2*pi./resonancesComplex;
  end
  
end






