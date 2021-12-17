function obj = interpolate_data(obj, wavelengths)

%obj.Wavelength = wavelengths;

obj.Irradiance = interp1(obj.Wavelength, obj.Irradiance, wavelengths);
%obj.Irradiance(1:spacing:end);
obj.SpectrumPhoton = Photon(wavelengths);
%obj.PowerDensityUntruncated = obj.PowerDensity;
