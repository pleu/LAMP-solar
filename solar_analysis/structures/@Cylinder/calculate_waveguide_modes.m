function [lambdaResonancesArray] = calculate_waveguide_modes(cy, betaArray, equationType, nus)

equationTypeChoices = {'leaky', 'guided', 'leakyTE', 'leakyTM'};

if nargin == 2
  equationType = 'leaky';
  nus = 0:3;
%  maxNu = 3;
elseif nargin == 3
  nus = 0:3;
end

if ~ismember(equationType, equationTypeChoices)
  error('The equation type is not known');
else
  op1 = cy(1).Material.OpticalProperties;
  op2 = cy(2).Material.OpticalProperties;
  
%  op1.K = zeros(length(op1.Wavelength), 1);
%  op2.K = zeros(length(op2.Wavelength), 1);
  op1.remove_infinite_wavelengths();
  op2.remove_infinite_wavelengths();
  radius = cy(1).Radius;
end

options = optimset('Display', 'iter', 'MaxIter', 400, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);


kGuessMax = min(2*pi./(min(op1.Wavelength)), 2*pi./(min(op2.Wavelength)));
kGuessMin = max(2*pi./(max(op1.Wavelength)), 2*pi./(max(op2.Wavelength)));

nkTryReal = 500;
nkTryImag = 501;
%kComplexScale = 10;
%kTry = [linspace(kGuessMin, kGuessMax, 10000); zeros(1, 10000)]';
kTryUnitReal = linspace(kGuessMin, kGuessMax, nkTryReal);
kTryUnitImag = linspace(-kGuessMax, kGuessMax, nkTryImag);
%; zeros(1, 100)]';
kTry = combvec(kTryUnitReal, kTryUnitImag)';
kTry = kTry(:, 1) + kTry(:, 2)*1i;

%kGuessMax = 2*pi./(min(op2.Wavelength*1e-9));
%kGuessMin = 2*pi./(max(op2.Wavelength*1e-9));
beta = betaArray(1);

nu = 0;
if strcmp(equationType, 'leaky')
  f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'leakyTM')
  f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'leakyTE')
  %f = @(x) Cylinder.leaky_mode_TE_real(x,nu,beta,op1,op2,radius);
  f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'guided')
  f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
end
eqn = feval(f, kTry);
eqn = vec2mat(eqn, nkTryReal);
[kGuess] = find_zeros_complex_x_complex_y(kTryUnitReal, kTryUnitImag, eqn);
%eqn = feval(f, kTry);
%[kGuess] = find_zeros(kTry(:, 1), eqn);
%kGuess = [kGuess zeros(length(kGuess), 1)];
%maxK = size(kGuess, 1)+2;
maxK = length(kGuess)+2;
kArray = zeros(maxK, length(betaArray));
%kArrayComplex = zeros(maxK, length(betaArray));

lambdaResonancesArray = zeros(length(nus), maxK, length(betaArray));

%for nu = 0:maxNu
for nuInd = 1:length(nus)
  nu = nus(nuInd);
  resonances = zeros(maxK, 2);
  for ind = 1:length(betaArray)
    beta = betaArray(ind);
    if strcmp(equationType, 'leaky')
      f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'leakyTM')
      f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'leakyTE')
      f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
      %f = @(x) Cylinder.leaky_mode_TE_real(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'guided')
      f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
    end
    eqn = feval(f, kTry);
    eqn = vec2mat(eqn, nkTryReal);
    [kGuess] = find_zeros_complex_x_complex_y(kTryUnitReal, kTryUnitImag, eqn);
    
    for m = 1:length(kGuess)
      % cannot use fzero because x must be real and function evaluation
      % must be real
      %[resonancesOut, fVal, exitFlag] = fzero(f, kGuess(m));
      [resonancesOut,fVal, exitFlag] = fsolve(f, kGuess(m), options);
      if exitFlag > 0
        resonances(m, :) = resonancesOut;
        % resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
      else
        resonances(m, :) = nan;
      end
      
    end
    %resonancesComplex = sort(complex(resonances(:, 1), resonances(:, 2)));
    kArray(:, ind) = resonances(1:maxK);
  end
  %[lambdaResonanceSort, ind] = sort(real(2*pi./kArray), 'descend');
  lambdaResonancesArray(nuInd, :, 1:length(betaArray)) = 2*pi./kArray;
end

end

