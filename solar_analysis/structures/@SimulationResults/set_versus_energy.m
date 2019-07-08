function set_versus_energy(sr, monitorType, energy, data)
  ma = sr.get_monitor(monitorType);
  ma.Energy = energy;
  ma.Data = data;
end