classdef DetailedSolarCell < SolarCell
% DetailedSolarCell class for solar cell
% Only considers radiative recombination
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2011
% Paul Leu 
  properties
    IV;
  end
  
%   properties(SetAccess = 'private', GetAccess = 'private')
%     SolarStructure;
%   end

  properties(SetAccess = 'private')
    CurrentDark; % in Amps/m^2
  end

  properties(Dependent)
%    Voltage;    % in Volts
%    CurrentTotal; % in Amps/m^2
    LimitingEfficiency; % max efficiency
    %UltimateEfficiency;
    %AbsorptionIntegrated;
    %CurrentSC;   % short circuit current
  end
  
  
  
  methods    
    function sc = DetailedSolarCell(solarSpectrum, structure, material, thetaE,... 
        internalFluorescence)
      sc@SolarCell(solarSpectrum, structure, material);
      if nargin > 0
        if nargin == 3
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
%           sc.IV = ...
%             DetailedSolarCell.calc_IV(...
%             material.BandGap, sc.Structure.AbsorptionResults, sc.CurrentSC, solarSpectrum);
        elseif nargin == 4
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
%           sc.IV = ...
%             DetailedSolarCell.calc_IV(...
%             material.BandGap, sc.Structure.AbsorptionResults, sc.CurrentSC,...
%             solarSpectrum, thetaE);
        elseif nargin == 5
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
%           sc.IV = ...
%             SolarCellIV.calc_IV(...
%             material.BandGap, sc.Structure.AbsorptionResults, sc.CurrentSC,...
%             solarSpectrum, thetaE, internalFluorescence,...
%             sc.Structure.Thickness, material);
        end
      end
    end
    
    function plotIV(sc)
      sc.IV.plot_IV;
    end
    
    function [limitingEfficiency] = get.LimitingEfficiency(sc)
      limitingEfficiency = sc.IV.Efficiency;
    end
    
    %     function [currentSC] = get.CurrentSC(sc)
    %       currentSC = sc.SolarStructure.CurrentSC;
    %     end
    %
    %     function [absorptionIntegrated] = get.AbsorptionIntegrated(sc)
    %       absorptionIntegrated = sc.SolarStructure.AbsorptionIntegrated;
    %     end
    
    %     function [ultimateEfficiency] = get.UltimateEfficiency(sc)
    %       ultimateEfficiency = sc.SolarStructure.UltimateEfficiency;
    %     end
    
    
    
    function sc = calcDetailedSimulationResults(sc)
      sc.DetailedSimulationResults = DetailedSimulation(sc.SolarSpectrum,...
        sc.Structure, sc.Voltage, sc.CurrentSC, sc.CurrentDark);
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
  
  methods(Static)
    
    
    function IV = calc_IV(bandGap, absorptionResults, currentSC, ...
        solarSpectrum, thetaE, internalFluorescence) %, thickness, material)
      
      if nargin < 5
        %thetaX = Constants.LightConstants.theta_s;
        thetaE = pi/2;
        internalFluorescence = 1;
        % thickness = 0;
      elseif nargin < 6
        internalFluorescence = 1;
        % thickness = 0;
      end
      
      %gammaX = pi*sin(thetaX)^2;
      gammaE = pi*sin(thetaE)^2;
      
      voltage = linspace(0, bandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
      EVector = linspace(bandGap, max(solarSpectrum.Energy));
      
      beVector = SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_a,...
        Constants.LightConstants.F_a);
      currentDark = zeros(1, size(voltage, 2));
      currentDark2 = zeros(1, size(voltage, 2));


      absorption = interp1(absorptionResults.Energy, absorptionResults.Data, ...
        EVector, 'linear', 'extrap'); 
      absorption(absorption < 0) = 0;
      
      if internalFluorescence == 1
        for voltageInd = 1:size(voltage, 2)
          currentDark(voltageInd) = Constants.LightConstants.Q* ...
          gammaE*trapz(EVector, (SolarSpectrum.calculate_be(EVector, voltage(voltageInd),...
          Constants.LightConstants.T_a, Constants.LightConstants.F_a) -...
          beVector).*absorption);
        end
%        currentDark2(voltageInd) = 0;
      else
%         N = interp1(material.OpticalProperties.Energy,...
%           material.OpticalProperties.N, EVector, 'linear', 'extrap');
% 
%         alpha = interp1(material.OpticalProperties.Energy,...
%           material.OpticalProperties.Alpha, EVector, 'linear', 'extrap');

        for voltageInd = 1:size(voltage, 2)
          %eta_ext = (1 - absorption)/(2 - absorption - internalFluorescence);
          currentDark(voltageInd) = Constants.LightConstants.Q* ...
            gammaE*trapz(EVector, (SolarSpectrum.calculate_be(EVector, voltage(voltageInd),...
            Constants.LightConstants.T_a, Constants.LightConstants.F_a) -...
            beVector).*absorption);
          % accounts for other internal loss mechanisms through 
          % internal fluorescence
          %alpha = 5e-3;
          %gammaE*
          % currentDark2
          %           currentDark2(voltageInd) = 1/...
          %             internalFluorescence*Constants.LightConstants.Q*thickness*...
          %             gammaE*trapz(EVector, (SolarSpectrum.calculate_bn(EVector, N,...
          %             voltage(voltageInd),...
          %             Constants.LightConstants.T_a, 4*Constants.LightConstants.F_a)).*absorption.*alpha);
          %*...
            %exp(voltage(voltageInd)/...
            %(2*Constants.LightConstants.k_B*Constants.LightConstants.T_a));
        end
      end
      currentTotal = currentSC-currentDark-currentDark2;
      IV = SolarCellIV(voltage, currentTotal, solarSpectrum.PowerDensity);   
    end

    
    test()
  end

end


