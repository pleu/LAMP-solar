function [absoluteEfficiency] = plot_absolute_efficiency_versus_energy(obj,...
  thetaX, thetaE)
%PLOT_ABSOLUTE_EFFICIENCY_VERSUS_ENERGY 
% Plot absolute efficiency as function of energy for a particular solar 
% spectrum
% 
% thetaX is the angle at which the sun reaches the cell
% thetaE is emission angle
%
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh

  gammaE = pi*sin(thetaE)^2;
  gammaX = pi*sin(thetaX)^2;
  
  absoluteEfficiency = zeros(obj.NumWavelength, 1);
  
  for ind = 1:obj.NumWavelength
    energyInd = find(obj.Energy >= obj.Energy(ind));
    voltage = linspace(0, obj.Energy(ind)-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
    if size(energyInd, 1) > 1
      currentDark = zeros(1, size(voltage, 2));
      EVector = linspace(obj.Energy(ind), max(obj.Energy));
      
      beVector = SolarSpectrum.calculate_b(EVector, 0, Constants.LightConstants.T_a);
      
      for voltageInd = 1:size(voltage, 2)
        currentDark(voltageInd) = Constants.LightConstants.Q ...
        *gammaE*trapz(EVector, (SolarSpectrum.calculate_b(EVector, voltage(voltageInd),...
        Constants.LightConstants.T_a) -...
        beVector));
      end
      
      currentSC = -Constants.LightConstants.Q*gammaX*...
        trapz(obj.Energy(energyInd), obj.PhotonFlux(energyInd))/...
      Constants.LightConstants.F_s;

      % account for fraction of thermal photons that have been replaced by 
      % solar radiation      
%       currentSC2 = -Constants.LightConstants.Q*...
%         (trapz(obj.Energy(energyInd),...
%         obj.PhotonFlux(energyInd))-...
%         Constants.LightConstants.F_s/Constants.LightConstants.F_a...
%         *trapz(EVector, beVector));
%       if ind == 448
%         keyboard;
%       end
      currentLight = currentSC-currentDark;
      iv = SolarCellIV(voltage, currentLight, obj.PowerDensity); 
      absoluteEfficiency(ind) = iv.Efficiency;
    else
      absoluteEfficiency(ind) = 0;
    end
    
  end
  
  
  % limitingEfficiency = limitingEfficiency/obj.PowerDensity;
  plot(obj.Energy, absoluteEfficiency);
  
  xlabel('Band Gap (eV)');
  ylabel('Absolute Efficiency');
end



