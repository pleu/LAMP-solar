function spectralcurrentSC = calculate_spectralcurrent_sc(sc, bandGap, absorptionResults)
% CALCULATE_CURRENT_SC
% Calculates short circuit current for perfectly absorbing, non-reflecting
% material
% 
% See also CALCULATE_CURRENT_DARK
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  absorption = interp1(absorptionResults.Energy, absorptionResults.Data, ...
    sc.SolarSpectrum.Energy);
  spectralcurrentSC = zeros(length(sc.SolarSpectrum.Energy), 1);
  bandGapIndex = find(sc.SolarSpectrum.Energy >= bandGap, 1, 'last');
  if bandGapIndex <= 1
    spectralcurrentSC = 0;
  else
    %spectralcurrentSC(bandGapIndex:-1:1) = Constants.LightConstants.Q*...
    %  sc.SolarSpectrum.Irradiance(bandGapIndex:-1:1)./sc.SolarSpectrum.Energy(bandGapIndex:-1:1).*...
    %  absorption(bandGapIndex:-1:1);
    %Irradiance;
    spectralcurrentSC(bandGapIndex:-1:1) = Constants.LightConstants.Q*...
      sc.SolarSpectrum.PhotonFlux(bandGapIndex:-1:1).*...
      absorption(bandGapIndex:-1:1).*(sc.SolarSpectrum.Energy(bandGapIndex:-1:1)).^2/Constants.LightConstants.HC/10;
  end
end
