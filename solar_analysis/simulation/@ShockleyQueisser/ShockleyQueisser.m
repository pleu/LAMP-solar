classdef DetailedSolarCell
% ShockleyQueisser class for solar cell
% Only considers radiative recombination
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2011
% Paul Leu 
  properties
    SolarStructure;
    IV;
  end
  
  properties(SetAccess = 'private')
    Voltage;    % in Volts
    CurrentDark; % in Amps/m^2
    CurrentTotal; % in Amps/m^2
  end
  
  properties(Dependent)
    Efficiency; % max efficiency
  end
  
  methods    
    function sc = ShockleyQueisser(solarSpectrum, structure, material)  
      if nargin > 0
        sc.SolarStructure = SolarCell(solarspectrum, structure, material);
        
        voltage = 
        
        sc.IV = SolarCellIV(voltage, currentLight, solarSpectrum.PowerDensity);
        
%        sc.Absorber = structure;
%        sc.CurrentSC = currentSC;
%        sc = sc.Simulate;
      end
    end
    
    function sc = calcDetailedSimulationResults(sc)
      sc.DetailedSimulationResults = DetailedSimulation(sc.SolarSpectrum,...
        sc.Structure, sc.Voltage, sc.CurrentSC, sc.CurrentDark);  
    end

    function efficiency = get.Efficiency(sc)
      efficiency = sc.SolarCellIV.Efficiency;
    end
    
    function sc = simulate(sc)
      sc.Voltage = sc.calcVoltage;
      sc.CurrentDark = sc.calc_current_dark;
      sc.CurrentTotal = sc.calcCurrentTotal; 
     
    end
    
    function currentDark = calc_current_dark(sc)
      currentDark = sc.calculate_current_dark(sc.Voltage,...
      sc.Material.BandGap, sc.Structure.AbsorptionResults);
    end
    
    function sc = Simulate(sc)
      sc.Voltage = sc.calcVoltage;
      sc.CurrentDark = sc.calcCurrentDark;
      sc.CurrentTotal = sc.calcCurrentTotal;
      
      sc.SolarCellIV = SolarCellIV(sc.Voltage, sc.CurrentDark,...
        sc.SolarSpectrum.PowerDensity); 
    end  
    
    function currentTotal = calcCurrentTotal(sc)
      currentTotal = sc.CurrentSC-sc.CurrentDark; 
    end
    
    function efficiency = calcEfficiency(sc)
      efficiency = (sc.Voltage.*sc.CurrentTotal)./ ...
        sc.SolarSpectrum.PowerDensity; 
    end
    
        
    function voltage = calcVoltage(sc)
      % a little below bandgap to avoid infinite exponential
      voltage = linspace(0, sc.Material.BandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
    end

    
%     function currentDark = calcCurrentDark2(sc)
%       currentDark = sc.calculate_current_dark2(sc.Voltage,...
%         sc.Structure.MaterialData.BandGap, sc.Structure.AbsorptionResults);
%      end
    
    function currentDark = calcCurrentDark(sc)
      currentDark = sc.calculate_current_dark(sc.Voltage,...
        sc.Material.BandGap, sc.Structure.AbsorptionResults);
    end
%        
%     function efficiency = get.Efficiency(sc)
%       efficiency = (sc.Voltage.*(sc.CurrentSC-sc.CurrentDark))./ ...
%         sc.SolarSpectrum.PowerDensity; 
%     end
% 
%     function limitingEfficiency = get.LimitingEfficiency(sc)
%       limitingEfficiency = max(sc.Efficiency);
%     end
%             
%     function maxInd = get.MaxInd(sc)
%       [~, maxInd] = max(sc.Efficiency);
%     end
% 
%     function voltageM = get.VoltageM(sc)
%       voltageM = sc.Voltage(sc.MaxInd);
%     end
%     function currentM = get.CurrentM(sc)
%       currentM = sc.CurrentSC-sc.CurrentDark(sc.MaxInd);
%     end
% 
%     function voltage = get.Voltage(sc)
%       % a little below bandgap to avoid infinite exponential
%       voltage = linspace(0, sc.Structure.MaterialData.BandGap-...
%         Constants.LightConstants.k_B*Constants.LightConstants.T_a);
%     end
%     function currentDark = get.CurrentDark(sc)
%       currentDark = sc.calculate_current_dark(sc.Voltage,...
%         sc.Structure.MaterialData.BandGap, sc.Structure.AbsorptionResults);
%     end

  end    

end


