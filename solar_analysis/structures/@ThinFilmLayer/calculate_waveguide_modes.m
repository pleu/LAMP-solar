function [lambdaResonancesArray] = calculate_waveguide_modes(tf, betaArray, TEorTM, equationType)

equationTypeChoices = {'leaky', 'guided', 'leakyOnMetal', 'guidedOnMetal', 'guidedAssymetric'};

if nargin == 3
  equationType = 'leaky';
end

if ~ismember(equationType, equationTypeChoices)
  error('The equation type is not known');
elseif strcmp(equationType, 'guidedAssymetric')
  op1 = tf(1).Material.OpticalProperties;
  op2 = tf(2).Material.OpticalProperties;
  op3 = tf(3).Material.OpticalProperties;
  
  op1.K = zeros(length(op1.Wavelength), 1);
  op2.K = zeros(length(op2.Wavelength), 1);
  op3.K = zeros(length(op2.Wavelength), 1);
  
  thickness = tf(2).Thickness;
else
  op1 = tf(1).Material.OpticalProperties;
  op2 = tf(2).Material.OpticalProperties;

  op1.K = zeros(length(op1.Wavelength), 1);
  op2.K = zeros(length(op2.Wavelength), 1);

  thickness = tf(2).Thickness;
end

options = optimset('Display', 'iter', 'MaxIter', 400, 'MaxFunEvals', 1e4, 'TolFun', 1e-9);

kGuessMax = min(2*pi./(min(op1.Wavelength)), 2*pi./(min(op2.Wavelength)));
kGuessMin = max(2*pi./(max(op1.Wavelength)), 2*pi./(max(op2.Wavelength)));

kTry = [linspace(kGuessMin, kGuessMax, 10000); zeros(1, 10000)]';


%kGuessMax = 2*pi./(min(op2.Wavelength*1e-9));
%kGuessMin = 2*pi./(max(op2.Wavelength*1e-9));
beta = betaArray(1);
if strncmp(TEorTM, 'TE', 2)
  if strcmp(equationType, 'leaky')
    f = @(x) ThinFilmLayer.waveguide_mode_TE(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guided')
    f = @(x) ThinFilmLayer.waveguide_mode_Yariv_TE(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guidedOnMetal')
    f = @(x) ThinFilmLayer.waveguide_mode_on_metal_Yariv_TE(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'leakyOnMetal')
    f = @(x) ThinFilmLayer.waveguide_mode_on_metal_TE(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guidedAssymetric')
    f = @(x) ThinFilmLayer.guided_waveguide_mode_assymetric_TE(x,beta,op1,op2,op3,thickness);
  end
else
  if strcmp(equationType, 'leaky')
    f = @(x) ThinFilmLayer.waveguide_mode_TM(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guided')
    f = @(x) ThinFilmLayer.waveguide_mode_Yariv_TM(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guidedOnMetal')
    f = @(x) ThinFilmLayer.waveguide_mode_on_metal_Yariv_TM(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'leakyOnMetal')
    f = @(x) ThinFilmLayer.waveguide_mode_on_metal_TM(x,beta,op1,op2,thickness);
  elseif strcmp(equationType, 'guidedAssymetric')
    f = @(x) ThinFilmLayer.guided_waveguide_mode_assymetric_TM(x,beta,op1,op2,op3,thickness);
  end
end
eqn = feval(f, kTry);
dEqn = diff(eqn);
indGuess = intersect(find(eqn(1:length(eqn)-1).*eqn(2:length(eqn))< 0),find(dEqn(1:length(dEqn)-1).*dEqn(2:length(dEqn))> 0));
kGuess = kTry(indGuess, :);

maxK = size(kGuess, 1)+2;
kArray = zeros(maxK, length(betaArray));
resonances = zeros(maxK, 2);
% kArrayComplex = zeros(maxK, length(betaArray));


for ind = 1:length(betaArray)
  beta = betaArray(ind);
  if strncmp(TEorTM, 'TE', 2)
    if strcmp(equationType, 'leaky')
      f = @(x) ThinFilmLayer.waveguide_mode_TE(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'guided')
      f = @(x) ThinFilmLayer.waveguide_mode_Yariv_TE(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'leakyOnMetal')
      f = @(x) ThinFilmLayer.waveguide_mode_on_metal_TE(x,beta,op1,op2,thickness);    
    elseif strcmp(equationType, 'guidedOnMetal')
      f = @(x) ThinFilmLayer.waveguide_mode_on_metal_Yariv_TE(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'guidedAssymetric')
      f = @(x) ThinFilmLayer.guided_waveguide_mode_assymetric_TE(x,beta,op1,op2,op3,thickness);
    end
  else
    if strcmp(equationType, 'leaky')
      f = @(x) ThinFilmLayer.waveguide_mode_TM(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'guided')
      f = @(x) ThinFilmLayer.waveguide_mode_Yariv_TM(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'leakyOnMetal')
      f = @(x) ThinFilmLayer.waveguide_mode_on_metal_TM(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'guidedOnMetal')
      f = @(x) ThinFilmLayer.waveguide_mode_on_metal_Yariv_TM(x,beta,op1,op2,thickness);
    elseif strcmp(equationType, 'guidedAssymetric')
      f = @(x) ThinFilmLayer.guided_waveguide_mode_assymetric_TE(x,beta,op1,op2,op3,thickness);
    end
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

lambdaResonancesArray = 2*pi./kArray;
