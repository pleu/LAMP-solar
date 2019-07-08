function [obj] = truncate_energy(obj, minEnergy, maxEnergy)
%TRUNCATE_ENERGY Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(obj, 2)
  obj(i).AbsorptionResults.truncate_energy(minEnergy, maxEnergy);
end



