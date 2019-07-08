bandgap = 1.5;

ss = SolarSpectrum.global_AM1p5();

jsc = Constants.LightConstants.Q*trapz(ss.Energy(ss.Energy> bandgap), ss.PhotonFlux(ss.Energy> bandgap))
