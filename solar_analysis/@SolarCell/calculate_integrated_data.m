function [dataIntegrated, warning] = calculate_integrated_data(SS,energy,data)
%CALCULATE_INTEGRATED_DATA
% Calculates the integrated data over the spectrum
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh

  %index = find(isnan(dataInterp));
  %dataInterp(index) = 0;
  warning = 0;

  if length(energy) == 1
    dataIntegrated = data;
  else
    if max(energy)>max(SS.Energy)
      %     dataInterp = interp1(energy, data, SS.Energy,'linear','extrap');
      photonFluxInterp = interp1(SS.Energy, SS.PhotonFlux, energy, 'linear', 'extrap');
      irrInterp = interp1(SS.Energy,SS.IrradianceEnergy, energy, 'linear', 'extrap');
      disp('PLEASE CHECK THE MAX FREQUENCY RANGE OF YOUR SIMULATION!');
      warning = 1;
    elseif min(energy)<min(SS.Energy)
      photonFluxInterp = interp1(SS.Energy, SS.PhotonFlux, energy, 'linear', 'extrap');
      
      %dataInterp = interp1(energy, data, SS.Energy,'linear','extrap');
      disp('PLEASE CHECK THE FREQUENCY RANGE OF YOUR SIMULATION!');
      warning = 1;
    else
      photonFluxInterp = interp1(SS.Energy, SS.PhotonFlux, energy);
      %irrInterp = interp1(energy,data, SS.Energy);
    end
    
    if size(SS.Energy) == 1
      dataIntegrated = dataInterp;
    else
      % Note: this is wrong!
       %dataIntegrated = -trapz(SS.Energy, ...
%         dataInterp.*SS.IrradianceEnergy)/SS.PowerDensity;
       %dataIntegrated = trapz(SS.Energy, ...
%           dataInterp.*SS.PhotonFlux)/trapz(SS.Energy, SS.PhotonFlux);
      %dataIntegrated = trapz(SS.Energy, ...
      %    dataInterp.*SS.PhotonFlux)/SS.NumPhotonsUntruncated;
      %   dataIntegrated = trapz(energy, ...
      %      data.*photonFluxInterp)/SS.NumPhotonsUntruncated;
      
      %      dataIntegrated = trapz(energy, ...
      %        data.*irrInterp)/SS.PowerDensity;
      dataIntegrated = trapz(energy, ...
        data.*photonFluxInterp)/SS.NumPhotons;
%       dataIntegrated = trapz(energySort, ...
%         data(ind, :).*(photonFluxInterp(ind)*ones(1, size(data, 2))))/SS.NumPhotons;
      
      % This was used previously
%      [energySort, ind] = sort(energy);
%      dataIntegrated = trapz(energySort, ...
%        data(ind).*photonFluxInterp(ind))/SS.NumPhotons;
    end
  end
end

