function set_versus_wavelength(sr, monitorType, wavelength, data)
  ma = sr.get_monitor(monitorType);
  if size(wavelength, 2) == 1
    ma.Wavelength = wavelength';
    ma.Data = data';
  else
    ma.Wavelength = wavelength;
    ma.Data = data;
  end
end