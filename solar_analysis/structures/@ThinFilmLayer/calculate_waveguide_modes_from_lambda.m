function [beta] = calculate_waveguide_modes_from_lambda(tf, lambda, TEorTM)
% lambda is in nm


op1 = tf(1).MaterialData.OpticalProperties;
op2 = tf(2).MaterialData.OpticalProperties;

n_r1 = interp1(op1.Wavelength, op1.N, lambda);
n_k1 = interp1(op1.Wavelength, op1.K, lambda);

n1 = n_r1 - sqrt(-1)*n_k1;


n_r2 = interp1(op2.Wavelength, op2.N, lambda);
n_k2 = interp1(op2.Wavelength, op2.K, lambda);

n2 = n_r2 - sqrt(-1)*n_k2;

V = sqrt(n2^2 - n1^2)*(pi*tf(2).Thickness/lambda);

numU = 10000;
%U = [linspace(0, V, numU)' zeros(numU, 1)];
U = linspace(0, V, numU)';
%zeros(numU, 1)];

U = [real(U), imag(U)];


if strncmp(TEorTM, 'TE', 2)
  eqn1 = ThinFilmLayer.symmetric_waveguide_mode_TE_beta(U,V);
  eqn2 = ThinFilmLayer.antisymmetric_waveguide_mode_TE_beta(U,V);
else
  eqn1 = ThinFilmLayer.symmetric_waveguide_mode_TM_beta(U,V,n1,n2);
  eqn2 = ThinFilmLayer.antisymmetric_waveguide_mode_TM_beta(U,V,n1,n2);
end
  
%indReal = find(abs(eqn(:, 1)) < 0.1);
indReal = find(eqn1(1:length(eqn1)-1,1).*eqn1(2:length(eqn1),1)<0);
indReal = indReal(eqn1(indReal)< 0);

UGuessSymmetric = U(indReal, 1);
betaEven = zeros(size(UGuessSymmetric, 1), 1);


indReal = find(eqn2(1:length(eqn2)-1,1).*eqn2(2:length(eqn2),1)<0);
indReal = indReal(eqn2(indReal)< 0);

UGuessAntiSymmetric = U(indReal, 1);
betaOdd = zeros(size(UGuessAntiSymmetric, 1), 1);

options = optimset('Display', 'iter', 'MaxIter', 1e3, 'MaxFunEvals', 1e3, 'TolFun', 1e-8);
for m = 1:length(UGuessSymmetric)
  if strncmp(TEorTM, 'TE', 2)
    f = @(x) ThinFilmLayer.symmetric_waveguide_mode_TE_beta(x,V);
  else
    f = @(x) ThinFilmLayer.symmetric_waveguide_mode_TM_beta(x,V,n1,n2);
  end
  [resonancesOut, fVal, exitFlag] = fsolve(f, [UGuessSymmetric(m), 0], options);
  
  if exitFlag == 1
    resonancesComplex = complex(resonancesOut(1), resonancesOut(2));
    betaOut = sqrt((n2*2*pi/lambda)^2-(2*resonancesComplex/tf(2).Thickness)^2);
    betaNormalized = betaOut/(2*pi/lambda);
    %resonancesComplex = complex(resonancesEven(m, 1), resonancesEven(m, 2));
    %beta(m, :) = betaOut;
    betaEven(m, :) = betaNormalized;
  else
    betaEven(m, 1) = nan;
  end
  
end


for m = 1:length(UGuessAntiSymmetric)
  if strncmp(TEorTM, 'TE', 2)
    f = @(x) ThinFilmLayer.antisymmetric_waveguide_mode_TE_beta(x,V);
  else
    f = @(x) ThinFilmLayer.antisymmetric_waveguide_mode_TM_beta(x,V,n1,n2);
  end
 
  [resonancesOut, fVal, exitFlag] = fsolve(f, [UGuessAntiSymmetric(m), 0], options);
  
  if exitFlag == 1
    resonancesComplex = complex(resonancesOut(1), resonancesOut(2));
    betaOut = sqrt((n2*2*pi/lambda)^2-(2*resonancesComplex/tf(2).Thickness)^2);
    betaNormalized = betaOut/(2*pi/lambda);
    %resonancesComplex = complex(resonancesEven(m, 1), resonancesEven(m, 2));
    %beta(m, :) = betaOut;
    betaOdd(m, :) = betaNormalized;
  else
    betaOdd(m, 1) = nan;
  end
  
end

beta = sort([betaEven; betaOdd], 'descend');







end
