function obj = truncate_energy(obj, minEnergy, maxEnergy)
% TRUNCATE_SPECTRUM
% truncates the wavelength to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

for i = 1:size(obj, 2)
  obj(i).ReflectionResults.truncate_energy(minEnergy, maxEnergy);
  obj(i).TransmissionResults.truncate_energy(minEnergy, maxEnergy);
  obj(i).AbsorptionResults.truncate_energy(minEnergy, maxEnergy);
end