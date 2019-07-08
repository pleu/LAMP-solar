function [ultimateEfficiency] = plot_ultimate_efficiency_versus_energy(obj)
%PLOT_ULTIMATE_EFFICIENCY_VERSUS_ENERGY 
% Plot ultimate efficiency as function of energy for a particular solar 
% spectrum
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

% TODO(Paul Leu): modify to handle where obj is an array
  ultimateEfficiency = zeros(obj.NumWavelength, 1);
  for ind = 1:obj.NumWavelength
    energyInd = find(obj.Energy >= obj.Energy(ind));
    if size(energyInd, 1) > 1
      ultimateEfficiency(ind) = -Constants.LightConstants.Q*...
        obj.Energy(ind)*trapz(obj.Energy(energyInd),...
        obj.PhotonFlux(energyInd));
    end
  end
  ultimateEfficiency = ultimateEfficiency/obj.PowerDensity;
  plot(obj.Energy, ultimateEfficiency);
  
  xlabel('Band Gap (eV)');
  ylabel('Ultimate Efficiency (%)');
end

