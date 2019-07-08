function [spectralCurrentSC] = calculate_spectral_current_sc(sc, bandGap, absorptionResults)
%CALCULATE_SPECTRAL_CURRENT_SC Summary of this function goes here
%   Detailed explanation goes here


spectralCurrentSC = zeros(1, length(absorptionResults.Energy));
bandGapIndex = find(absorptionResults.Energy >= bandGap);
photonFluxInterp = interp1(sc.SolarSpectrum.Energy, sc.SolarSpectrum.PhotonFlux, absorptionResults.Energy,'linear','extrap');
if bandGapIndex >= 1
  spectralCurrentSC(bandGapIndex) = Constants.LightConstants.Q*absorptionResults.Data(bandGapIndex).* ...
    photonFluxInterp(bandGapIndex);
end

spectralCurrentSC = set_range(spectralCurrentSC, 0, Inf);



% for i = 1:length(bandGapIndex) 
%     if bandGapIndex(i) >= 1
%     spectralCurrentSC(i) = Constants.LightConstants.Q*absorptionResults.Data(i).* ...
%     photonFluxInterp(i);
%     end
% end
% 
% b=[0 0 0 0];
% c=[10 10 20 30];
% a=[1 2 3 4];
% if a>1
%     b(a)=c(a);
% end