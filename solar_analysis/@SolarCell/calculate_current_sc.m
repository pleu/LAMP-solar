function currentSC = calculate_current_sc(obj)
% CALCULATE_CURRENT_SC
% Calculates short circuit current for perfectly absorbing, non-reflecting
% material
% 
% See also CALCULATE_CURRENT_DARK
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  %absorption = interp1(absorptionResults.Energy, absorptionResults.Data, ...
%    sc.SolarSpectrum.Energy, 'linear', 'extrap');
  %bandGapIndex = find(absorptionResults.Energy >= bandGap);
  %photonFluxInterp = interp1(sc.SolarSpectrum.Energy, sc.SolarSpectrum.PhotonFlux, absorptionResults.Energy);
 % if bandGapIndex <= 1
%    currentSC = 0;
  %else
    %     currentSC = Constants.LightConstants.Q*...
    %       trapz(sc.SolarSpectrum.Energy(bandGapIndex:-1:1), ...
    %       sc.SolarSpectrum.PhotonFlux(bandGapIndex:-1:1).*...
    %       absorption(bandGapIndex:-1:1));
    %currentSC = Constants.LightConstants.Q* ...
%      trapz(absorptionResults.Energy(bandGapIndex), absorptionResults.Data(bandGapIndex).* ...
%      photonFluxInterp(bandGapIndex));
currentSC = trapz(obj.spectralCurrentSC.Energy, obj.spectralCurrentSC.Data);
    
%     currentSC = Constants.LightConstants.Q*... 
%       trapz(sc.SolarSpectrum.Energy(bandGapIndex:-1:1), ...
%       sc.SolarSpectrum.PhotonFlux(bandGapIndex:-1:1).*...
%       absorption(bandGapIndex:-1:1));
  %end
end
