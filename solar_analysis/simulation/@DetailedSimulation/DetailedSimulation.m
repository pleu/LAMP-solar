classdef DetailedSimulation
% Detailed class for solar cell
% Considers radiative recombination, Auger recombination, and free carrier
% absorption
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2011
% Paul Leu 
  properties
    SolarSpectrum;
    Structure;
    Voltage;    % in Volts
    CurrentSC;
    CurrentDark;
 %   IncludeAuger; 
    CurrentAuger; % in Amps/m^2
    CurrentFreeCarrierAbsorption;
    CurrentFreeCarrierAbsorption2;
    CurrentDarkDetailed;
    CurrentDetailedTotal;
    
    LimitingEfficiencyDetailed; 
    Efficiency; % efficiency as function of voltage
    
    MaxInd;
    VoltageM;   % voltage at limiting efficiency, in Volts
    CurrentM;   % current at limiting efficiency, in Amps/m^2
    FF;     % fill factor
    VOC;    % open circuit voltage
  end
  
  methods    
    function sc = DetailedSimulation(solarSpectrum, structure, voltage,...
        currentSC, currentDark)  
      if nargin > 0
        sc.SolarSpectrum = solarSpectrum;
        sc.Structure = structure;
        sc.Voltage = voltage;
        sc.CurrentSC = currentSC;
        sc.CurrentDark = currentDark;
%        sc.CurrentSC = currentSC;
        sc = sc.Simulate;
        % sc.IncludeAuger = 0;        
      end
    end

    function sc = Simulate(sc)
      sc.CurrentAuger = sc.calc_currentAuger;
      [sc.CurrentFreeCarrierAbsorption, sc.CurrentFreeCarrierAbsorption2]...
        = sc.calc_currentFreeCarrierAbsorption;
      sc.CurrentDarkDetailed = sc.calc_currentDarkDetailed;
      sc.CurrentDetailedTotal = sc.calc_currentDetailedTotal;
      sc.Efficiency = (sc.Voltage.*sc.CurrentDetailedTotal)./ ...
        sc.SolarSpectrum.PowerDensity;
      sc.LimitingEfficiencyDetailed = max(sc.Efficiency);
      if sum(sc.CurrentDetailedTotal) == 0
        sc.MaxInd = nan;
        sc.VoltageM = nan;
        sc.CurrentM = nan;
        sc.VOC = nan;
        sc.FF = nan;
      else
        [sc.MaxInd, sc.VoltageM, sc.CurrentM, sc.VOC, sc.FF] = ...
        ShockleyQueisser.calcSolarCellCharacteristics(...
          sc.Efficiency, sc.CurrentDetailedTotal, sc.Voltage, sc.CurrentSC);
      end
    end  

    function efficiency = calcEfficiency(sc)
      efficiency = (sc.Voltage.*sc.CurrentDetailedTotal)./ ...
        sc.SolarSpectrum.PowerDensity; 
    end
    
    function currentDarkDetailed = calc_currentDarkDetailed(sc)
      currentDarkDetailed = sc.CurrentDark+sc.CurrentAuger+...
        sc.CurrentFreeCarrierAbsorption;
    end
    
    function currentDetailedTotal = calc_currentDetailedTotal(sc)
      currentDetailedTotal = sc.CurrentSC-sc.CurrentDarkDetailed;
    end
    
    function [currentFreeCarrierAbsorption, currentFreeCarrierAbsorption2] = calc_currentFreeCarrierAbsorption(sc)
    % This only works for thin film or Lambertian structure  
      %EVector = linspace(bandGap, max(sc.SolarSpectrum.Energy));
      EVector = linspace(sc.Structure.MaterialData.BandGap, max(sc.SolarSpectrum.Energy));
      absorption = interp1(sc.Structure.AbsorptionResults.Energy,...
        sc.Structure.AbsorptionResults.Data, EVector, 'linear', 'extrap'); 
      absorption(absorption < 0) = 0;
      N = interp1(sc.Structure.MaterialData.OpticalProperties.Energy,...
        sc.Structure.MaterialData.OpticalProperties.N, EVector, 'linear', 'extrap');
      currentFreeCarrierAbsorption = zeros(1,size(sc.Voltage, 2));
      currentFreeCarrierAbsorption2 = zeros(1,size(sc.Voltage, 2));
      for ind = 1:size(sc.Voltage, 2)
        currentFreeCarrierAbsorption(1, ind) = Constants.LightConstants.Q*...
        sc.Structure.Thickness*Constants.UnitConversions.NMtoCM*...
        sc.Structure.MaterialData.Alpha_FreeCarrier*...
        sc.Structure.MaterialData.Ni*...
        exp(sc.Voltage(ind)/...
        (2*Constants.LightConstants.k_B*Constants.LightConstants.T_a))*...
        trapz(EVector, absorption.*...
        sc.SolarSpectrum.calculate_bn(EVector, N, sc.Voltage(ind),...
        Constants.LightConstants.T_a, 4*Constants.LightConstants.F_a));
      
        currentFreeCarrierAbsorption2(1, ind) = Constants.LightConstants.Q*...
        sc.Structure.Thickness*Constants.UnitConversions.NMtoCM*...
        sc.Structure.MaterialData.Alpha_FreeCarrier*...
        sc.Structure.MaterialData.Ni*...
        exp(sc.Voltage(ind)/...
        (2*Constants.LightConstants.k_B*Constants.LightConstants.T_a))*...
        trapz(EVector, absorption.*...
        sc.SolarSpectrum.calculate_bn(EVector, N, 0,...
        Constants.LightConstants.T_a, 4*Constants.LightConstants.F_a)).*...
        exp(sc.Voltage(ind)/(Constants.LightConstants.k_B...
        *Constants.LightConstants.T_a));
      end
    end
    
    function currentAuger = calc_currentAuger(sc)
    % This only works for thin film or Lambertian structure  
      currentAuger = Constants.LightConstants.Q*...
        sc.Structure.Thickness*Constants.UnitConversions.NMtoCM*...
        sc.Structure.MaterialData.AugerCoefficient*...
        sc.Structure.MaterialData.Ni^3*...
        exp(3*sc.Voltage/...
        (2*Constants.LightConstants.k_B*Constants.LightConstants.T_a))*...
        Constants.UnitConversions.CMperM^2;
    end
    
    function FF = calcFF(sc)
      FF = sc.VoltageM*sc.CurrentM/(sc.CurrentSC*sc.VOC);
    end

    function currentTotal = calcCurrentTotal(sc)
      currentTotal = sc.CurrentSC-sc.CurrentDark; 
    end
  
  end
  
  methods(Static)
    test();
  end
end


