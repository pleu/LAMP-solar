function [F0, energyVector, F0spectralEnergy, F0spectralNM] = calculate_F0(sa, ma)
n = 1;
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

absorptionGrid = zeros(length(thetaVector), length(energyVector), length(phiVector));
[energyGrid, thetaGrid, phiGrid] = meshgrid(energyVector, thetaVector, phiVector); % x and y need to be flipped


for ind = 1:va.NumValues
  thetaCurrent = va.Values(ind, indTheta);
  phiCurrent = va.Values(ind, indPhi);
  absorptionGrid(thetaVector==thetaCurrent,[1:bandgapInd-1 bandgapInd+1:end],phiVector==phiCurrent) = sa.Simulations(ind).AbsorptionResults.Data;
  absorptionGrid(thetaVector==thetaCurrent, bandgapInd, phiVector==phiCurrent) = interp1(sa.Simulations(ind).AbsorptionResults.Energy, sa.Simulations(ind).AbsorptionResults.Data, ma.BandGap);
end

be = SolarSpectrum.calculate_bn(energyVector, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a)';
beGrid = repmat(be, length(thetaVector), 1, length(phiVector));
%beCheck = SolarSpectrum.calculate_bn(1.34, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a)

integrand = beGrid.*absorptionGrid.*cosd(thetaGrid).*sind(thetaGrid);

%F0 = Constants.LightConstants.Q*trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), trapz(energyVector(energyVector >= ma.BandGap), integrand(:, energyVector >= ma.BandGap, :),2), 1), 3);
F0spectralEnergy = Constants.LightConstants.Q*trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), integrand, 1), 3);
F0 = trapz(energyVector(energyVector >= ma.BandGap), F0spectralEnergy(energyVector >= ma.BandGap));

F0spectralNM = F0spectralEnergy.*energyVector'.^2./(Constants.LightConstants.HC);
%F0check = trapz(Photon.convert_energy_to_wavelength(energyVector(energyVector >= ma.BandGap)), F0spectralNM(energyVector >= ma.BandGap));

end