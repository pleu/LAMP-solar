function [lambdaResonancesArray] = calculate_waveguide_modes_between_metal(tf, betaArray)
% this is on metal
% TEorTM = 'TE', 'TM', or 'both'; default is 'both'

op = tf.MaterialData.OpticalProperties;

mMax = 10;

lambdaResonances = zeros(mMax, 1);
mArray = 1:mMax;
kZeros = (mArray*pi)./(tf.Thickness);

lambdaResonancesArray = zeros(mMax, length(betaArray));

for ind = 1:length(betaArray)
  beta = betaArray(ind);
  
  q = sqrt((op.Wavenumber.*op.N).^2 - beta^2); % k_x

  for m = 1:mMax
    %if ind == 80 & m == 1
%      keyboard;
%    end
    eqn = q - kZeros(m);
    indZero = find(real(eqn(2:length(eqn))).*real(eqn(1:length(eqn)-1)) < 0);
    %[minVal, minInd] = min(abs(eqn));
    %lambdaResonances(m) = interp1(eqn(ind-1:minInd+1), op.Wavelength(minInd-1:minInd+1), 0);
    if isempty(indZero)
      lambdaResonances(m) = nan;
    else
      lambdaResonances(m) = interp1(eqn(indZero:indZero+1), op.Wavelength(indZero:indZero+1), 0);
    end
  end
  lambdaResonancesArray(:, ind) = lambdaResonances;
  
end






