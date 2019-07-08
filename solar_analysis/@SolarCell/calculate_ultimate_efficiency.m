function [ultimateEfficiency] = calculate_ultimate_efficiency(spectrum,...
  bandGap, absorptionResults)
% CALCULATE_ULTIMATE_EFFICIENCY
% Calculates ultimate efficiency
% Only uses wavelengths above the bandgap
% 
% Copyright 2012
% Paul Leu 
% LAMP, University of Pittsburgh
  bandGapIndex = find(absorptionResults.Energy >= bandGap);
  if max(absorptionResults.Energy) > max(spectrum.Energy)
%    absorption = interp1(absorptionResults.Energy, ...
%      absorptionResults.Data, spectrum.Energy,'linear','extrap'); 
    photonFluxInterp = interp1(spectrum.Energy, spectrum.PhotonFlux, absorptionResults.Energy, 'linear', 'extrap');
    disp('PLEASE CHECK THE FREQUENCY RANGE OF YOUR SIMULATION!');
  elseif min(absorptionResults.Energy) < min(spectrum.Energy)
    photonFluxInterp = interp1(spectrum.Energy, spectrum.PhotonFlux, absorptionResults.Energy, 'linear', 'extrap');
    %absorption = interp1(absorptionResults.Energy, ...
    %absorptionResults.Data, spectrum.Energy,'linear','extrap'); 
    disp('PLEASE CHECK THE FREQUENCY RANGE OF YOUR SIMULATION!');
  else
    photonFluxInterp = interp1(spectrum.Energy, spectrum.PhotonFlux, absorptionResults.Energy); 
  end
  if bandGapIndex <= 1
    ultimateEfficiency = 0;
  else
    absorptionData = absorptionResults.Data(bandGapIndex);
    indBad = find(absorptionData < 0);
    if ~isempty(indBad)
      disp('Warning in ultimate efficiency calculation: some absorption < 0');
      absorptionData(indBad) = 0;
    end
    indBad = find(absorptionData > 1);
    if ~isempty(indBad)
      disp('Warning in ultimate efficiency calculation: some absorption > 1');
      absorptionData(indBad) = 1;
    end
    
%     ultimateEfficiency = Constants.LightConstants.Q*bandGap * ...
%       trapz(spectrum.Energy(bandGapIndex:-1:1), absorption(bandGapIndex:-1:1).* ...
%       spectrum.PhotonFlux(bandGapIndex:-1:1))/spectrum.PowerDensityUntruncated;
    ultimateEfficiency = Constants.LightConstants.Q*bandGap * ...
      trapz(absorptionResults.Energy(bandGapIndex), absorptionData.* ...
      photonFluxInterp(bandGapIndex))/spectrum.PowerDensityUntruncated;
  end
end

