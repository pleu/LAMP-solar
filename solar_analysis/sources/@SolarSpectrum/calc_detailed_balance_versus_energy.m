function [IV] = calc_detailed_balance_versus_energy(obj, varargin)
%PLOT_LIMITING_EFFICIENCY_VERSUS_ENERGY 
% Plot limiting efficiency as function of energy for a particular solar 
% spectrum without consideration of internal flourescence
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
% TODO(Paul Leu): modify to handle where obj is an array
  limitingEfficiency = zeros(obj.NumWavelength, 1);
  
  %bandGap = 0.5;
  %[value, indBandgap] = min(abs(obj.Energy-bandGap));
  %currentSC = zeros(length(obj.NumWavelength), 1);
  IV = SolarCellIV.empty(obj.NumWavelength, 0);
  for ind = 1:obj.NumWavelength
%     if ind == 2000
%       keyboard;
%     end
    bandGap = obj.Energy(ind);
    energyInd = find(obj.Energy >= bandGap);
    %deltaE = [0; diff(obj.Energy)];
    
    if size(energyInd, 1) > 1
      %       currentSC = -Constants.LightConstants.Q*...
      %         trapz(obj.Energy(energyInd),...
      %         obj.PhotonFlux(energyInd));
      %       currentSC(ind) = -Constants.LightConstants.Q*...
      %         sum(obj.PhotonFlux(energyInd).*deltaE(energyInd));
      %IV = SolarCellIV.calc_IVNelson(bandGap, currentSC(ind), obj); 
      IV(ind) = SolarCellIV.calc_IVRuhle(bandGap, obj); 
    else
      IV(ind) = SolarCellIV.create_zero_efficiency_cell(obj); 
    end
    
  end
 
end

