function [betaArray] = calculate_waveguide_modes_from_lambda2(tf, lambdaArray, TEorTM)
% lambda is in nm


op1 = tf(1).MaterialData.OpticalProperties;
op2 = tf(2).MaterialData.OpticalProperties;

% thickness = tf(2).Thickness*1e-9;
% betaRange = linspace(0, 0.08)'*1e9;
% % max modes will be at minimum wavelength; 
% minLambda = min(lambdaArray)*1e-9;

thickness = tf(2).Thickness;
betaRange = linspace(0, 0.08)';
% max modes will be at minimum wavelength; 
minLambda = min(lambdaArray);


if strncmp(TEorTM, 'TE', 2)
  %f = @(x) ThinFilmLayer.leaky_resonance_mode_2d(x,op,tf.Thickness);
  eqn = ThinFilmLayer.waveguide_mode_TE2([2*pi./minLambda 0],betaRange,op1,op2,thickness);
  %      eqn = ThinFilmLayer.waveguide_mode_TE([kGuess(m) 0],beta,op,tf.Thickness);
else
  eqn = ThinFilmLayer.waveguide_mode_TM([2*pi./minLambda 0],betaRange,op1,op2,thickness);
  %eqn = ThinFilmLayer.waveguide_mode_TM([kGuess(m) 0],beta, op,tf.Thickness);
end

indReal = find(eqn(1:length(eqn)-1,1).*eqn(2:length(eqn),1)<0);
maxBeta = size(indReal, 1);

betaArray = nan*ones(maxBeta, length(lambdaArray));


%V = sqrt(n2^2 - n1^2)*(pi*tf(2).Thickness/lambda);

%numU = 10000;
%U = [linspace(0, V, numU)' zeros(numU, 1)];
%U = linspace(0, V, numU)';
%zeros(numU, 1)];

%U = [real(U), imag(U)];

options = optimset('Display', 'iter', 'MaxIter', 1e4, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);
%ThinFilmLayer.leaky_resonance_mode_2d([real(kGuess) imag(kGuess)], op, tf.Thickness)

for ind = 1:length(lambdaArray)
  lambda = lambdaArray(ind);
  %indReal = find(eqn1(1:length(eqn1)-1,1).*eqn1(2:length(eqn1),1)<0);
  %indReal = indReal(eqn1(indReal)< 0);
  
  if strncmp(TEorTM, 'TE', 2)
    %f = @(x) ThinFilmLayer.leaky_resonance_mode_2d(x,op,tf.Thickness);
    eqn = ThinFilmLayer.waveguide_mode_TE2([2*pi./lambda 0],betaRange,op1,op2,thickness);
    %      eqn = ThinFilmLayer.waveguide_mode_TE([kGuess(m) 0],beta,op,tf.Thickness);
  else
    eqn = ThinFilmLayer.waveguide_mode_TM([2*pi./lambda 0],betaRange,op1,op2,thickness);
    %eqn = ThinFilmLayer.waveguide_mode_TM([kGuess(m) 0],beta, op,tf.Thickness);
  end
  
  indReal = find(eqn(1:length(eqn)-1,1).*eqn(2:length(eqn),1)<0);
  %indReal = indReal(eqn(indReal)< 0);

  betaGuess = betaRange(indReal);
  resonances = zeros(size(indReal, 1), 1);

  
  for m = 1:length(betaGuess)
    %beta = betaGuess(m);
    %resonances(m, 1)
    if strncmp(TEorTM, 'TE', 2)
      %f = @(x) ThinFilmLayer.leaky_resonance_mode_2d(x,op,tf.Thickness);
      f = @(beta) ThinFilmLayer.waveguide_mode_TE2([2*pi./lambda 0],beta,op1,op2,thickness);
      %      eqn = ThinFilmLayer.waveguide_mode_TE([kGuess(m) 0],beta,op,tf.Thickness);
    else
      f = @(beta) ThinFilmLayer.waveguide_mode_TM([2*pi./lambda 0],beta,op1,op2,thickness);
      %eqn = ThinFilmLayer.waveguide_mode_TM([kGuess(m) 0],beta, op,tf.Thickness);
    end
    %indReal = find(eqn(:, 1) < -0.1);
    [resonancesOut, fVal, exitFlag] = fsolve(f, betaGuess(m), options);
    %resonancesSymmetric(m, :)
    if exitFlag == 1
      resonances(m, :) = resonancesOut;
    else
      resonances(m, :) = nan;
    end
  end
  
  betaArray(1:length(resonances), ind) = resonances;
  
  
  %   for m = 1:length(kGuessAntiSymmetric)
%     if strncmp(TEorTM, 'TE', 2)
%       %f = @(x) ThinFilmLayer.leaky_resonance_mode_2d(x,op,tf.Thickness);
%       f = @(x) ThinFilmLayer.antisymmetric_waveguide_mode_TE(x,beta,op1,op2,thickness);
%       %      eqn = ThinFilmLayer.waveguide_mode_TE([kGuess(m) 0],beta,op,tf.Thickness);
%     else
%       f = @(x) ThinFilmLayer.antisymmetric_waveguide_mode_TM(x,beta,op1,op2,thickness);
%       %eqn = ThinFilmLayer.waveguide_mode_TM([kGuess(m) 0],beta, op,tf.Thickness);
%     end
%     %indReal = find(eqn(:, 1) < -0.1);
%     [resonancesOut, fVal, exitFlag] = fsolve(f, [real(kGuessAntiSymmetric(m)), imag(kGuessAntiSymmetric(m))], options);
%     if exitFlag == 1
%       resonancesAntiSymmetric(m, :) = resonancesOut;
%       resonancesComplex = complex(resonancesAntiSymmetric(m, 1), resonancesAntiSymmetric(m, 2));
%       lambdaResonancesAntiSymmetric(m, ind) = 2*pi./resonancesComplex;
%     else
%       lambdaResonancesAntiSymmetric(m, ind) = nan;
%     end    
%   end
  
end
  
  



end
