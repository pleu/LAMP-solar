function [lambdaResonancesArray] = calculate_waveguide_modes(cy, betaArray, equationType)

equationTypeChoices = {'leaky', 'guided', 'leakyTE', 'leakyTM'};

if nargin == 2
  equationType = 'leaky';
end

if ~ismember(equationType, equationTypeChoices)
  error('The equation type is not known');
else

  equationTypeChoices = {'leaky', 'guided', 'leakyTE', 'leakyTM'};
  
  if nargin == 2
    equationType = 'leaky';
  end
  
  if ~ismember(equationType, equationTypeChoices)
    error('The equation type is not known');
  else
    op1 = cy(1).Material.OpticalProperties;
    op2 = cy(2).Material.OpticalProperties;
    
    op1.K = zeros(length(op1.Wavelength), 1);
    op2.K = zeros(length(op2.Wavelength), 1);
    
    radius = cy(1).Radius;
  end
  
  options = optimset('Display', 'iter', 'MaxIter', 400, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);
  
  kGuessMax = min(2*pi./(min(op1.Wavelength)), 2*pi./(min(op2.Wavelength)));
  kGuessMin = max(2*pi./(max(op1.Wavelength)), 2*pi./(max(op2.Wavelength)));
  
  kTry = [linspace(kGuessMin, kGuessMax, 10000); zeros(1, 10000)]';
  
  
  %kGuessMax = 2*pi./(min(op2.Wavelength*1e-9));
  %kGuessMin = 2*pi./(max(op2.Wavelength*1e-9));
  beta = betaArray(1);
  
  nu = 0;
  if strcmp(equationType, 'leaky')
    f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
  elseif strcmp(equationType, 'leakyTM')
    f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
  elseif strcmp(equationType, 'leakyTE')
    f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
  elseif strcmp(equationType, 'guided')
    f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
  end
  eqn = feval(f, kTry);
  dEqn = diff(eqn);
  indGuess = intersect(find(eqn(1:length(eqn)-1).*eqn(2:length(eqn))< 0),find(dEqn(1:length(dEqn)-1).*dEqn(2:length(dEqn))> 0));
  kGuess = kTry(indGuess, :);
  
  maxK = size(kGuess, 1)+2;
  
  kArray = zeros(maxK, length(betaArray));
  
  % kArrayComplex = zeros(maxK, length(betaArray));
  maxNu = 3;
  
  lambdaResonancesArray = zeros(maxNu+1, maxK, length(betaArray));
  
  
  for nu = 0:maxNu
    resonances = zeros(maxK, 2);
    for ind = 1:length(betaArray)
      beta = betaArray(ind);
      if strcmp(equationType, 'leaky')
        f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
      elseif strcmp(equationType, 'leakyTM')
        f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
      elseif strcmp(equationType, 'leakyTE')
        f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
      elseif strcmp(equationType, 'guided')
        f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
      end
      eqn = feval(f, kTry);
      dEqn = diff(eqn);
      indGuess = intersect(find(eqn(1:length(eqn)-1).*eqn(2:length(eqn))< 0),find(dEqn(1:length(dEqn)-1).*dEqn(2:length(dEqn))> 0));
      kGuess = kTry(indGuess, :);
      
      for m = 1:size(kGuess, 1)
        [resonancesOut, fVal, exitFlag] = fsolve(f, kGuess(m, :), options);
        if exitFlag > 0
          resonances(m, :) = resonancesOut;
          % resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
        else
          resonances(m, :) = nan;
        end
        
      end
      resonancesComplex = sort(complex(resonances(:, 1), resonances(:, 2)));
      kArray(:, ind) = resonancesComplex(1:maxK);
    end
    lambdaResonancesArray(nu+1, 1:length(kArray), ind) = 2*pi./kArray;
  end
end
op1 = cy(1).Material.OpticalProperties;
op2 = cy(2).Material.OpticalProperties;

op1.K = zeros(length(op1.Wavelength), 1);
op2.K = zeros(length(op2.Wavelength), 1);

radius = cy(1).Radius;
end

options = optimset('Display', 'iter', 'MaxIter', 400, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);

kGuessMax = min(2*pi./(min(op1.Wavelength)), 2*pi./(min(op2.Wavelength)));
kGuessMin = max(2*pi./(max(op1.Wavelength)), 2*pi./(max(op2.Wavelength)));

kTry = [linspace(kGuessMin, kGuessMax, 10000); zeros(1, 10000)]';


%kGuessMax = 2*pi./(min(op2.Wavelength*1e-9));
%kGuessMin = 2*pi./(max(op2.Wavelength*1e-9));
beta = betaArray(1);

nu = 0;
if strcmp(equationType, 'leaky')
  f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'leakyTM')
  f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'leakyTE')
  f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
elseif strcmp(equationType, 'guided')
  f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
end
eqn = feval(f, kTry);
dEqn = diff(eqn);
indGuess = intersect(find(eqn(1:length(eqn)-1).*eqn(2:length(eqn))< 0),find(dEqn(1:length(dEqn)-1).*dEqn(2:length(dEqn))> 0));
kGuess = kTry(indGuess, :);

maxK = size(kGuess, 1)+2;

kArray = zeros(maxK, length(betaArray));

% kArrayComplex = zeros(maxK, length(betaArray));
maxNu = 3;

lambdaResonancesArray = zeros(maxNu+1, maxK, length(betaArray));


for nu = 0:maxNu
  resonances = zeros(maxK, 2);
  for ind = 1:length(betaArray)
    beta = betaArray(ind);
    if strcmp(equationType, 'leaky')
      f = @(x) Cylinder.leaky_mode(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'leakyTM')
      f = @(x) Cylinder.leaky_mode_TM(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'leakyTE')
      f = @(x) Cylinder.leaky_mode_TE(x,nu,beta,op1,op2,radius);
    elseif strcmp(equationType, 'guided')
      f = @(x) Cylinder.guided_mode(x,nu,beta,op1,op2,radius);
    end
    eqn = feval(f, kTry);
    dEqn = diff(eqn);
    indGuess = intersect(find(eqn(1:length(eqn)-1).*eqn(2:length(eqn))< 0),find(dEqn(1:length(dEqn)-1).*dEqn(2:length(dEqn))> 0));
    kGuess = kTry(indGuess, :);
    
    for m = 1:size(kGuess, 1)
      [resonancesOut, fVal, exitFlag] = fsolve(f, kGuess(m, :), options);
      if exitFlag > 0
        resonances(m, :) = resonancesOut;
        % resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
      else
        resonances(m, :) = nan;
      end
      
    end
    resonancesComplex = sort(complex(resonances(:, 1), resonances(:, 2)));
    kArray(:, ind) = resonancesComplex(1:maxK);
  end
  lambdaResonancesArray(nu+1, 1:length(kArray), 1:length(betaArray)) = 2*pi./kArray;
end



