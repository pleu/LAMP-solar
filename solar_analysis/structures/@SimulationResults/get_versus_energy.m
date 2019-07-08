function [energy, data] = get_versus_energy(sr, monitorType)
  ma = sr.get_monitor(monitorType);
  energy = ma.Energy;
  data = ma.Data;
end