function spectrum = read_CIE()
%
% reads in photopic vision data

  data=load([LAMPsolar_data_path, '/solar_spectrum/VMlambda1988.txt']);
  energy = Photon.convert_wavelength_to_energy(data(:, 1));
  irradianceEnergy = SolarSpectrum.convert_photon_flux_to_irradiance_energy(data(:, 2), energy);
  irradiance = SolarSpectrum.convert_irradiance_energy_to_irradiance(irradianceEnergy, energy);
  spectrum = SolarSpectrum('VM(lambda) 1988 Spectral Luminous Efficiency Function for photopic vision', data(:, 1), irradiance);
end