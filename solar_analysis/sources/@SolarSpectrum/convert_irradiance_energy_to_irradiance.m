function irradiance = convert_irradiance_energy_to_irradiance(irradianceEnergy, energy)
  irradiance = irradianceEnergy.*(energy.^2)./Constants.LightConstants.HC;
end

