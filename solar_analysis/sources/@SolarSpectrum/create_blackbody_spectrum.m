function obj = create_blackbody_spectrum(temperature, wavelength)
%CREATE_BLACKBODY_SPRECTRUM
% Create black body spectrum for body at particular temperature
%
% wavelength is vector, which is the wavelength range of interest
%
% Copyright 2012
% Paul Leu
if nargin == 1
  ASTMG173=load([LAMPsolar_data_path, '/solar_spectrum/ASTMG173.txt']);
  wavelength = ASTMG173(:, 1);
end
energy = Photon.ConvertWavelengthToEnergy(wavelength);
%be = SolarSpectrum.calculate_be_omega(energy, 0, temperature, Constants.LightConstants.F_s);
be = SolarSpectrum.calculate_be_omega(energy, 0, temperature);
irradianceEnergy = SolarSpectrum.convert_photon_flux_to_irradiance_energy(be, energy);
irradiance = SolarSpectrum.convert_irradiance_energy_to_irradiance(irradianceEnergy, energy);
obj = SolarSpectrum([num2str(temperature) 'K Black Body '], wavelength, irradiance);
end

