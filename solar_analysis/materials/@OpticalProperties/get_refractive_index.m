function refractiveIndex = get_refractive_index(obj, wavelengths)
  refractiveIndex = interp1(obj.Wavelength, obj.RefractiveIndex, wavelengths);
end