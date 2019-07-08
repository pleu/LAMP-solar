function n = get_n(obj, wavelengths)
  n = interp1(obj.Wavelength, obj.N, wavelengths);
end
