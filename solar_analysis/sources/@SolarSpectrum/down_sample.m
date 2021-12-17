function obj = down_sample(obj, spacing)

wavelength = obj.Wavelength(1:spacing:end);
obj.Irradiance = obj.Irradiance(1:spacing:end);
obj.SpectrumPhoton = Photon(wavelength);
%obj.PowerDensityUntruncated = obj.PowerDensity;




