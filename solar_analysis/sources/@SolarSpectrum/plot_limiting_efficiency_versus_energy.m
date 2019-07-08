function [limitingEfficiency] = plot_limiting_efficiency_versus_energy(obj, varargin)
%PLOT_LIMITING_EFFICIENCY_VERSUS_ENERGY 
% Plot limiting efficiency as function of energy for a particular solar 
% spectrum without consideration of internal flourescence
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
% TODO(Paul Leu): modify to handle where obj is an array
  limitingEfficiency = zeros(obj.NumWavelength, 1);
  
  bandGap = 0.5;
  [value, indBandgap] = min(abs(obj.Energy-bandGap));
  
  for ind = 1:obj.NumWavelength
    if ind == indBandgap
      keyboard;
    end
    bandGap = obj.Energy(ind);
    energyInd = find(obj.Energy >= bandGap);
    
    if size(energyInd, 1) > 1
      currentSC = -Constants.LightConstants.Q*...
        trapz(obj.Energy(energyInd),...
        obj.PhotonFlux(energyInd));      
      IV = SolarCellIV.calc_IV2(bandGap, currentSC, obj); 
      limitingEfficiency(ind) = IV.Efficiency;
    else
      limitingEfficiency(ind) = 0;
    end
    
  end
  
  
  % limitingEfficiency = limitingEfficiency/obj.PowerDensity;
  optionplot(obj.Energy, limitingEfficiency, varargin);
  
  xlabel('Band Gap (eV)');
  ylabel('Limiting Efficiency');
end

