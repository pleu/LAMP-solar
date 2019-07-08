function [lambdaResonancesArray] = calculate_waveguide_modes(ns, TEorTM, squareOrHex)
%CALCULATE_MODES Summary of this function goes here
%   Detailed explanation goes here
nuMax = 4;

if strncmp(squareOrHex, 's', 1)
  factorArray = [1 sqrt(2) 2 sqrt(5) sqrt(8)];
else
  factorArray = [sqrt(4/3) 2 sqrt(16/3)];
end

op = ns.MaterialData.OpticalProperties;

nu = 1;
k0 = linspace(2*pi./(max(op.Wavelength)*1e-9), 2*pi./(min(op.Wavelength)*1e-9))';
radius = ns.Diameter(1)*1e-9/2; 

k = [k0 zeros(length(kReal), 1)];

if strncmp(TEorTM, 'TE', 2)
  eqn = Nanosphere.TE_mode(k,op,radius, nu);
else
  eqn = Nanosphere.TM_mode(k,op,radius, nu);
end

indReal = find(eqn(:, 1) < -0.1);
%indConsReal = find(diff(indReal) ~= 1);
%kGuess = k([indReal(indConsReal) max(indReal)]);
x = [0 cumsum(diff(indReal')~=1)];
indConsReal = [1 find(diff(x) == 1)+1];

kGuess = k(indReal(indConsReal));

kArray = nan*ones(nuMax, size(kGuess, 2));

lambdaResonancesArray = zeros(nuMax, size(kGuess, 2), length(ns.Diameter));

for j = 1:length(factorArray)
  factor = factorArray(j);
  for ind = 1:length(ns.Diameter)
    radius = ns.Diameter(ind)*1e-9/2;
    beta = 2*pi/(ns.Diameter(ind)*1e-9)*factor;
    for nu = 1:nuMax
      %     if ind  == 1 && nu == 3
      %       keyboard;
      %     end
      options = optimset('Display', 'iter', 'MaxIter', 1e3, 'MaxFunEvals', 1e3, 'TolFun', 1e-8);
      %k = [kReal zeros(length(kReal), 1)];
      
      %k = [2*pi./(op.Wavelength*1e-9) zeros(length(op.Wavelength), 1)];
      
      if strncmp(TEorTM, 'TE', 2)
        eqn = Nanosphere.TE_mode(k,op,radius,nu);
        f = @(k) Nanosphere.TE_mode(k,op,radius,nu);
      else
        eqn = Nanosphere.TM_mode(k,op,radius,nu);
        f = @(k) Nanosphere.TM_mode(k,op,radius,nu);
      end
      
      indReal = find(eqn(:, 1) < -0.1);
      %indConsReal = find(diff(indReal) ~= 1);
      %kGuess = k([indReal(indConsReal) max(indReal)]);
      if ~isempty(indReal)
        x = [0 cumsum(diff(indReal')~=1)];
        indConsReal = [1 find(diff(x) == 1)+1];
        
        kGuess = k(indReal(indConsReal));
      end
      %kGuess = k([indReal(indConsReal); max(indReal)]);
      
      %   indReal = find(eqn(:, 1) < -0.1);
      %   %indConsReal = find(diff(indReal) ~= 1);
      %
      %   %kGuess = k([indReal(indConsReal) max(indReal)]);
      %   kGuess = k([indReal(diff(indReal) ~= 1); max(indReal)]);
      resonances = zeros(size(kGuess, 1), 2);
      
      for m = 1:length(kGuess)
        [resonancesOut, fVal, exitFlag] = fsolve(f, [kGuess(m), 0], options);
        if exitFlag == 1
          resonances(m, :) = resonancesOut;
          %  resonancesComplex = complex(resonances(m, 1), resonances(m, 2));
          %      lambdaResonances(m, 1) = 2*pi./resonancesComplex;
        else
          indReal2 = find(eqn(:, 1) < -0.1);
          indConsReal2 = find(diff(indReal2) ~= 1)';
          if ~isempty(indConsReal2)
            kGuess2b = k(indReal2(indConsReal2));
            [val, indTry] = min(abs(real(kGuess(m))-kGuess2b));
            [resonancesOutB, fVal, exitFlagB] = fsolve(f, [real(kGuess2b(indTry)), imag(kGuess2b(indTry))], options);
            if exitFlagB == 1
              resonances(m, :) = resonancesOutB;
            else
              resonances(m, :) = nan;
            end
            
            
          end
          %lambdaResonances(m, 1) = nan;
        end
      end
      kArray(nu, 1:size(resonances, 1)) = complex(resonances(:, 1), resonances(:, 2));
      
    end
    lambdaResonancesArray(1:size(kArray, 1), 1:size(kArray, 2), ind) = ...
      2*pi./kArray*1e9;
    %lambdaResonances = 2*pi./kArray*1e9;
  end
  
  
  
end


