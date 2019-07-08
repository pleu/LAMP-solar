function obj = adjust_optical_properties(obj, wavelengths)
% Adjusts optical properties for new wavelengths using linear
% interpolation
  obj.N = interp1(obj.Wavelength, obj.N, wavelengths);
  obj.K = interp1(obj.Wavelength, obj.K, wavelengths);
  obj.Wavelength = wavelengths;
end

