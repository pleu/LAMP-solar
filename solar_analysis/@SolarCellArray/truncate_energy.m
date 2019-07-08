function [obj] = truncate_energy(obj, minEnergy, maxEnergy)

for i = 1:size(obj.SolarCells, 2)
  obj.SolarCells(i).truncate_energy(minEnergy, maxEnergy);
end

