function obj = create_wavelength(wavelength)
%CREATE_WAVELENGTHS
%
% wavelength is vector, which is the wavelength range of interest
%
% Copyright 2015
% Paul Leu
irradiance = 1;
obj = SolarSpectrum('Wavelengths', [wavelength], [irradiance]);
end