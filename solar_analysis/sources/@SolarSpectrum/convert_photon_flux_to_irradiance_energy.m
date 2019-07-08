function irradianceEnergy = convert_photon_flux_to_irradiance_energy(photonFlux, energy)
  irradianceEnergy = photonFlux.*energy.*Constants.LightConstants.Q;
end

