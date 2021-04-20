function [Jsc] = calculate_Jsc(sa, ma, ss)
% Calculate J_sc at theta = 0 and phi = 0
[q, idx] = ismember([0 0], sa.VariableArray.Values, 'rows');
%sa.VariableArray.Values == [0 0]

% minWavelength = round(min(sa.Simulations(1).AbsorptionResults.Wavelength)); % round because some slight numerical error
% maxWavelength = round(max(sa.Simulations(1).AbsorptionResults.Wavelength));
% ss.truncate_spectrum_wavelength(minWavelength, maxWavelength);

sa.Simulations(idx).AbsorptionResults

energyVector = sa.Simulations(idx).ReflectionResults.Energy';
energyVector = sort([energyVector; ma.BandGap]);

dataVector = interp1(sa.Simulations(idx).ReflectionResults.Energy, sa.Simulations(idx).AbsorptionResults.Data, energyVector);

wavelengthData = [279.5; ss.Wavelength];
photonFluxData = [0; ss.PhotonFlux];
energyData = Photon.convert_wavelength_to_energy(wavelengthData);

photonFlux = interp1(energyData, photonFluxData, energyVector); % # of photons/m^2*sec^(-1)*eV^-1
Jsc = Constants.LightConstants.Q*trapz(energyVector(energyVector >= ma.BandGap), dataVector(energyVector >= ma.BandGap).*photonFlux(energyVector >= ma.BandGap))*Constants.UnitConversions.AmpsPerM2tomAmpsPerCm2;

%material = MaterialType.create('Si');
%sc = SolarCell(ss, sa.Simulations(idx), ma);

%currentSC = trapz(obj.spectralCurrentSC.Energy, obj.spectralCurrentSC.Data);
