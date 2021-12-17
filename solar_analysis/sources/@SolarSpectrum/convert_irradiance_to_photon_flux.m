function photonFlux = convert_irradiance_to_photon_flux(irradiance, energy)
photonFlux = irradiance./(energy.*Constants.LightConstants.Q);
%irradianceEnergy = photonFlux.*energy.*Constants.LightConstants.Q;
end
