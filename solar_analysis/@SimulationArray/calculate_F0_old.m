function F0 = calculate_F0_old(sa, ma)
n = 1;
va = sa.VariableArray; 
% check to make sure variable array has both 'Theta' and 'Phi' to do
% calculations

energyVector = sa.Simulations(1).ReflectionResults.Energy';
energyVector = sort([energyVector; ma.BandGap]);
bandgapInd = find(energyVector == ma.BandGap);

%energiesRelevant = 
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

% add in band gap

be = SolarSpectrum.calculate_bn(energyVector, n, 0, Constants.LightConstants.T_c, Constants.LightConstants.F_a)';
beGrid = repmat(be, length(thetaVector), 1, length(phiVector));


integrand = beGrid.*absorptionGrid.*cos(thetaGrid).*sin(thetaGrid);

%F0 = Constants.LightConstants.Q*trapz(EVector, SolarSpectrum.calculate_bn(EVector, n, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a));

%energyInd = find(energyVector >= ma.BandGap);
F0 = trapz(deg2rad(phiVector), trapz(deg2rad(thetaVector), trapz(energyVector(energyVector >= ma.BandGap), integrand(:, energyVector >= ma.BandGap, :),2), 1), 3);

%absorptionGrid;
%thetaArray = test;
%


%deltaE = [diff(energyVector); 0]; % 0 at back
% 
%EVector = ss.Energy(energyInd);
%deltaEInt = deltaE(energyInd);


%F0 = sum(SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_c, Constants.LightConstants.F_a).*deltaEInt);

%currentDark0 = Constants.LightConstants.Q*
      % factor of 2 because of emission from top and bottom;

      
      
%currentDark0 = -geometricFactor*Constants.LightConstants.Q*sum(SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_c, Constants.LightConstants.F_a).*deltaEInt);
      % factor of 2 because of emission from top and bottom;


