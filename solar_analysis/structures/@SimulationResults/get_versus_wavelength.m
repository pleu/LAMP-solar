function [wavelength, data] = get_versus_wavelength(sr, monitorType)
  ma = sr.get_monitor(monitorType);
  wavelength = ma.Wavelength;
  data = ma.Data;
end