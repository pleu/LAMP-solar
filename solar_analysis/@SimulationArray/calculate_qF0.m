function [F0, energyVector, F0spectralEnergy, F0spectralNM] = calculate_qF0(sa, ma, n)

va = sa.VariableArray; 
va.check_if_variable('Theta')
va.check_if_variable('Phi')
% check to make sure variable array has both 'Theta' and 'Phi' to do
% calculations
%F0 = 0;

energyVector = sa.Simulations(1).ReflectionResults.Energy';
energyVector = sort([energyVector; ma.BandGap]);
bandgapInd = find(energyVector == ma.BandGap);

indTheta = va.get_variable_ind('Theta');
indPhi = va.get_variable_ind('Phi');

thetaVector = unique(va.Values(:, indTheta));
phiVector = unique(va.Values(:, indPhi));

absorptionGrid = zeros(length(energyVector), length(thetaVector), length(phiVector));
%[energyGrid2, thetaGrid2, phiGrid2] = meshgrid(energyVector, thetaVector, phiVector); % x and y need to be flipped
[energyGrid, thetaGrid, phiGrid] = ndgrid(energyVector, thetaVector, phiVector); % x and y need to be flipped

for ind = 1:va.NumValues
  thetaCurrent = va.Values(ind, indTheta);
  phiCurrent = va.Values(ind, indPhi);
  absorptionGrid([1:bandgapInd-1 bandgapInd+1:end],thetaVector==thetaCurrent,phiVector==phiCurrent) = sa.Simulations(ind).AbsorptionResults.Data;
  absorptionGrid(bandgapInd, thetaVector==thetaCurrent, phiVector==phiCurrent) = interp1(sa.Simulations(ind).AbsorptionResults.Energy, sa.Simulations(ind).AbsorptionResults.Data, ma.BandGap);
end

be = SolarSpectrum.calculate_bn(energyVector, n, 0, Constants.LightConstants.T_c,1)';
beGrid = repmat(be', 1, length(thetaVector), length(phiVector));
%beCheck = SolarSpectrum.calculate_bn(1.34, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a)

integrand = beGrid.*absorptionGrid.*cosd(thetaGrid).*sind(thetaGrid);

%F0 = Constants.LightConstants.Q*trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), trapz(energyVector(energyVector >= ma.BandGap), integrand(:, energyVector >= ma.BandGap, :),2), 1), 3);
F0spectralEnergy = Constants.LightConstants.Q*trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), integrand, 2), 3);
%F0spectralEnergyCheck = Constants.LightConstants.Q*trapz(deg2rad(thetaVector), trapz(deg2rad(phiVector), integrand, 3), 2);
% figure(1);
% clf;
% plot(energyVector, F0spectralEnergy, 'b-');
%hold on;
%plot(energyVector, F0spectralEnergyCheck, 'g--');
F0 = trapz(energyVector(energyVector >= ma.BandGap), F0spectralEnergy(energyVector >= ma.BandGap));

F0spectralNM = F0spectralEnergy.*energyVector.^2./(Constants.LightConstants.HC);

% blambda = SolarSpectrum.calculate_bn_lambda(Photon.convert_energy_to_wavelength(energyVector), n, Constants.LightConstants.T_a,1)';
% blambdaGrid = repmat(blambda', 1, length(thetaVector), length(phiVector));
% integrand = blambdaGrid.*absorptionGrid.*cosd(thetaGrid).*sind(thetaGrid);
% F0spectralNMcheck = Constants.LightConstants.Q*trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), integrand, 2), 3);
% 
% F0check = -trapz(Photon.convert_energy_to_wavelength(energyVector(energyVector >= ma.BandGap)), F0spectralNM(energyVector >= ma.BandGap));
% F0check2 = -trapz(Photon.convert_energy_to_wavelength(energyVector(energyVector >= ma.BandGap)), F0spectralNMcheck(energyVector >= ma.BandGap));
% figure(2);
% clf;
% plot(Photon.convert_energy_to_wavelength(energyVector), 8*F0spectralNM*Constants.UnitConversions.AmpsPerM2tomAmpsPerCm2, 'b-');
% hold on;
%plot(energyVector, F0spectralEnergyCheck, 'g--');


end