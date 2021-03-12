function obj = down_sample(obj, spacing)

obj.Wavelength = obj.Wavelength(1:spacing:end);
obj.Irradiance = obj.Irradiance(1:spacing:end);
obj.SpectrumPhoton = Photon(obj.Wavelength);
%obj.PowerDensityUntruncated = obj.PowerDensity;




