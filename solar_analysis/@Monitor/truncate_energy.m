function obj = truncate_energy(obj, minEnergy, maxEnergy)
%TRUNCATE_ENERGY Summary of this function goes here
%   Detailed explanation goes here
for i = 1:size(obj, 2)
  [obj(i).Energy, obj(i).Data] = ...
    truncate(obj(i).Energy', minEnergy, maxEnergy, obj(i).Data');
end


