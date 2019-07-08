function [lambdaResonances] = calculate_leaky_modes_between_metal(tf)

op = tf.MaterialData.OpticalProperties;

mMax = 10;

lambdaResonances = zeros(mMax, 1);
mArray = 1:mMax;
kZeros = (mArray*pi)./(tf.Thickness);

for m = 1:mMax
  eqn = op.Wavenumber.*op.N - kZeros(m);
  [minVal, minInd] = min(abs(eqn));
  lambdaResonances(m) = interp1(eqn(minInd-1:minInd+1), op.Wavelength(minInd-1:minInd+1), 0);
end

