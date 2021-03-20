classdef SolarCellIV
% SolarCellIV class for solar cell
% Analyzes IV characteristics of a solar cell
% 
% Copyright 2012
% Paul Leu 
  properties
    Voltage;    % in Volts
    CurrentLight; % in Amps/m^2
    PowerDensity;  % Watts/m^2
  end
  
  properties(Hidden)
    MaxInd; % index of where maximum efficiency occurs for Voltage and 
            % CurrentDark
  end
  
  properties(SetAccess = private)
    CurrentSC; % current when voltage = 0
    Efficiency; % max efficiency
    EfficiencyArray; % efficiency as function of voltage

    VoltageM;   % voltage at limiting efficiency, in Volts
    CurrentM;   % current at limiting efficiency, in Amps/m^2
    FF;     % fill factor
    VOC;    % open circuit voltage
  end
  
  methods
    
    function iv = SolarCellIV(voltage, currentLight, powerDensity)  
      if nargin > 0
        iv.Voltage = voltage;
        iv.CurrentLight = currentLight;
        iv.PowerDensity = powerDensity;
        iv = iv.Analyze;
      end
    end
  end
  
    
  methods(Hidden)
    function iv = Analyze(iv)
      if sum(iv.CurrentLight) == 0
        iv.CurrentSC = 0
        iv.MaxInd = nan;
        iv.VoltageM = nan;
        iv.CurrentM = nan;
        iv.VOC = 0;
        iv.FF = 0;
        iv.Efficiency = 0;
      else      
        iv.CurrentSC = iv.calc_CurrentSC;
        iv.EfficiencyArray = iv.calc_efficiency;
        [iv.Efficiency, iv.MaxInd] = max(iv.EfficiencyArray);
        iv.VoltageM = iv.Voltage(iv.MaxInd);
        iv.CurrentM = iv.CurrentLight(iv.MaxInd);
        iv.VOC = iv.calc_VOC(iv.Voltage, iv.CurrentLight);
        iv.FF = iv.VoltageM*iv.CurrentM/(iv.CurrentSC*iv.VOC);  
      end
    end
    
    function efficiency = calc_efficiency(iv)
      if iv.CurrentSC < 0
        efficiency = -(iv.Voltage.*iv.CurrentLight)./ ...
          iv.PowerDensity;
      else
        efficiency = (iv.Voltage.*iv.CurrentLight)./ ...
          iv.PowerDensity;
      end
    end
    
    function currentSC = calc_CurrentSC(iv)
      currentSC = interp1(iv.Voltage, iv.CurrentLight, 0);
    end
    
  end
  
  methods(Static)

    function IV = calc_IV_detailed_balance(currentSC, F0, ma, ss)
      voltage = linspace(0, ma.BandGap);
      currentTotal = Constants.LightConstants.Q*F0*(exp(Constants.LightConstants.Q*voltage/(Constants.LightConstants.k_B*Constants.LightConstants.T_c))-1)-currentSC;
      IV = SolarCellIV(voltage, currentTotal, ss.PowerDensity);   
    end

    
    function IV = create_zero_efficiency_cell(ss)
      voltage = linspace(0, 1);
      currentTotal = zeros(length(voltage), 1);
      IV = SolarCellIV(voltage, currentTotal, ss.PowerDensity);   
    end
    
    function [VOC] = calc_VOC(voltage, current)
%      VOC = interp1(current, voltage, 0);
       [~, ind] = min(abs(current));
       indices = [ind-1 ind ind+1];
       indices = indices(indices > 0 & indices <= length(current));
       h = diff(current(indices));
       if any(h == 0)
         VOC = nan;
       else
         VOC = interp1(current(indices), voltage(indices), 0);       
       end
    end
    

    
    function IV = calc_IVRuhle(bandGap, ss)
      % This is based on Ruhle, Tabulated values of the Shockley?Queisser limit for single junction solar cells
      geometricFactor = 2;
      %energyInd = find(ss.Energy >= bandGap);
      %      deltaE = [diff(ss.Energy); 0]; % 0 at back
      %       currentSC = -Constants.LightConstants.Q*...
      %         sum(ss.PhotonFlux(energyInd).*deltaE(energyInd));
      EVector = ss.Energy(ss.Energy >= bandGap);
      %      deltaEInt = deltaE(energyInd);
      currentMax = -Constants.LightConstants.Q*...
        trapz(EVector, ss.PhotonFlux(energyInd)); % this is more accurate than below
      %       currentMax2 = -Constants.LightConstants.Q*...
      %         sum(ss.PhotonFlux(energyInd).*deltaE(energyInd))
      currentDark0 = -geometricFactor*Constants.LightConstants.Q*trapz(EVector, SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_c, Constants.LightConstants.F_a));
      %currentDark0 = -geometricFactor*Constants.LightConstants.Q*sum(SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_c, Constants.LightConstants.F_a).*deltaEInt);
      % factor of 2 because of emission from top and bottom;
      currentSC = currentMax - currentDark0;
      voltage = linspace(0, bandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a, 200);
      currentDark = zeros(1, size(voltage, 2));
      for voltageInd = 1:size(voltage, 2)
%         currentDark(voltageInd) = -Constants.LightConstants.Q*geometricFactor*...
%           sum(SolarSpectrum.calculate_be(EVector, voltage(voltageInd), Constants.LightConstants.T_c, Constants.LightConstants.F_a).*deltaEInt) - currentDark0;
        currentDark(voltageInd) = -Constants.LightConstants.Q*geometricFactor*...
          trapz(EVector, SolarSpectrum.calculate_be(EVector, voltage(voltageInd), Constants.LightConstants.T_c, Constants.LightConstants.F_a)) - currentDark0;
      end
      %currentSC = currentS - currentDark0;
      %currentSC = currentS;
      currentTotal = currentSC-currentDark;
      IV = SolarCellIV(voltage, currentTotal, ss.PowerDensity);   
    end
    
    function IV = calc_IVNelson(bandGap, currentSC, solarSpectrum)
      % This is based on Nelson textbook
      % This includes the factor of -Fs/Fe where a fraction of ambient flux
      % has been replaced by solar radiation
      EVector = linspace(bandGap, max(solarSpectrum.Energy));
      deltaE = [diff(EVector) 0];
      currentDark0 = Constants.LightConstants.Q*sum(SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a).*deltaE);
      %Constants.LightConstants.Q*geometricalFactor*trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));
      % trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));
      % *trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));
      %currentDark0 = Constants.LightConstants.Q*geometricalFactor*trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));
      %currentAbs = (1 - Constants.LightConstants.F_s/Constants.LightConstants.F_a)*currentDark0;
      voltage = linspace(0, bandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
      currentDark = zeros(1, size(voltage, 2));
      for voltageInd = 1:size(voltage, 2)
        currentDark(voltageInd) = Constants.LightConstants.Q*...
          sum(SolarSpectrum.calculate_be(EVector, voltage(voltageInd), Constants.LightConstants.T_a, Constants.LightConstants.F_a).*deltaE);
      end
      currentSCadjust = currentSC - Constants.LightConstants.F_s/Constants.LightConstants.F_a*currentDark0;
      currentTotal = currentSCadjust-(currentDark-currentDark0);
      IV = SolarCellIV(voltage, currentTotal, solarSpectrum.PowerDensity);   
    end
    
    function IV = calc_IV2(bandGap, currentSC, ...
        solarSpectrum)
      % This is based on Nelson textbook
      geometricalFactor = pi;
      
      
      
      voltage = linspace(0, bandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
      EVector = linspace(bandGap, max(solarSpectrum.Energy));
      
      % current with no voltage
      currentDark0 = Constants.LightConstants.Q*geometricalFactor*trapz(EVector, SolarSpectrum.calculate_be_omega(EVector, 0, Constants.LightConstants.T_a));
      
      % current with voltage
      currentDark = zeros(1, size(voltage, 2));
      for voltageInd = 1:size(voltage, 2)
        currentDark(voltageInd) = Constants.LightConstants.Q* ...
            geometricalFactor*trapz(EVector, (SolarSpectrum.calculate_be_omega(EVector, voltage(voltageInd),...
            Constants.LightConstants.T_a)));
      end
      currentTotal = currentSC-(currentDark-currentDark0);
      IV = SolarCellIV(voltage, currentTotal, solarSpectrum.PowerDensity);   
    end
    
    
    
    function IV = calc_IV(bandGap, absorptionResults, currentSC, ...
        solarSpectrum, thetaE, internalFluorescence, thickness, material)
      % This is based on Yablanovitch paper; need to put in reference 
      % and document formulas
      if nargin < 5
        %thetaX = Constants.LightConstants.theta_s;
        thetaE = pi/2;
        internalFluorescence = 1;
        thickness = 0;
      elseif nargin < 6
        internalFluorescence = 1;
        thickness = 0;
      end
      
      %gammaX = pi*sin(thetaX)^2;
      gammaE = pi*sin(thetaE)^2;
      
      voltage = linspace(0, bandGap-...
        Constants.LightConstants.k_B*Constants.LightConstants.T_a);
      EVector = linspace(bandGap, max(solarSpectrum.Energy));
      
      beVector = SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_a, Constants.LightConstants.F_a);
      currentDark = zeros(1, size(voltage, 2));
      currentDark2 = zeros(1, size(voltage, 2));

      % not sure if this is right; EVector is energy above band gap
      % EVector is length 100 
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
        N = interp1(material.OpticalProperties.Energy,...
          material.OpticalProperties.N, EVector, 'linear', 'extrap');

        alpha = interp1(material.OpticalProperties.Energy,...
          material.OpticalProperties.Alpha, EVector, 'linear', 'extrap');

        for voltageInd = 1:size(voltage, 2)
          %eta_ext = (1 - absorption)/(2 - absorption - internalFluorescence);
          currentDark(voltageInd) = Constants.LightConstants.Q* ...
            gammaE*trapz(EVector, (SolarSpectrum.calculate_b(EVector, voltage(voltageInd),...
            Constants.LightConstants.T_a) -...
            beVector).*absorption);
          % accounts for other internal loss mechanisms through 
          % internal fluorescence
          %alpha = 5e-3;
          %gammaE*
          % currentDark2
          currentDark2(voltageInd) = 1/...
            internalFluorescence*Constants.LightConstants.Q*thickness*...
            gammaE*trapz(EVector, (SolarSpectrum.calculate_bn(EVector, N,... 
            voltage(voltageInd),...
            Constants.LightConstants.T_a, 4*Constants.LightConstants.F_a)).*absorption.*alpha);
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

