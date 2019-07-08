function obj = create_single_wavelength(wavelength)
%CREATE_SINGLE_WAVELENGTH
%
% wavelength is vector, which is the wavelength range of interest
%
% Copyright 2015
% Paul Leu

%irradiance = 1;


ph = Photon(wavelength);
%irradiance = (obj.Energy).^3./Constants.LightConstants.HC.*Constants.LightConstants.Q;
irradiance = (ph.Energy).^3./Constants.LightConstants.HC;


% irradianceEnergy = obj.Irradiance*Constants.LightConstants.HC./(obj.Energy).^2;
% photonFlux = obj.IrradianceEnergy./obj.Energy./Constants.LightConstants.Q;
% 
% obj.Irradiance*Constants.LightConstants.HC./(obj.Energy).^2;
% 
% 
% photonFlux = obj.IrradianceEnergy./obj.Energy./Constants.LightConstants.Q;
% photonFlux =
% obj.Irradiance*Constants.LightConstants.HC./(obj.Energy).^2./obj.Energy./Constants.LightConstants.Q


obj = SolarSpectrum([num2str(wavelength) ' nm Wavelength'], wavelength, irradiance);
end