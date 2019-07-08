function obj = truncate_spectrum_energy(obj, minEnergy, maxEnergy)
% TRUNCATE_SPECTRUM_ENERGY
% truncates the solar spectrum to just values between
% minWavelength and maxWavelength
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

disp('Do not truncate the solar spectrum.  Please truncate the simulation results instead.');
for i = 1:size(obj, 2)
  [obj(i).Energy, obj(i).Irradiance] = ...
    truncate(obj(i).Energy, minEnergy, maxEnergy, obj(i).Irradiance);
end
