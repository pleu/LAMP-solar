classdef SolarCell < handle
% SolarCell class for solar cell
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2011
% Paul Leu 
  properties
    SolarSpectrum;
    Structure; % this must be an Absorber
    Material;
  end

  properties(SetAccess='private')
%    SQSimulation; %Shockley Queisser simulation results
    CurrentSC;  % in Amps/m^2 (times .1 for mA/cm^2)
    
%    SolarCellIV;
    UltimateEfficiency; % maximum efficiency    
%    LimitingEfficiency; % maximum efficiency, considering radiative 
                        % recombination
    
      
%    LimitingEfficiencyDetailed; % maximum efficiency, 
                        % considering radiative recombination, Auger
                        % recombination and free carrier absorption
                        
    AbsorptionIntegrated;   % Structure must include an Absorption Results 
                            % variable                            
    ReflectionIntegrated;   % Structure must include an Reflection Results 
                            % variable 
    TransmissionIntegrated; % Structure must include an Transmission Results 
                            % variable 
    SpectralCurrentSC;      % Monitor object                       
  end
  
  methods    
    function sc = SolarCell(solarSpectrum, structure, material)
      if nargin > 0
        if nargin == 2
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
        elseif nargin == 3
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
        end
      end
      sc.UltimateEfficiency = SolarCell.calculate_ultimate_efficiency(sc.SolarSpectrum,...
        sc.Material.BandGap, sc.Structure.AbsorptionResults);
      
      spectralCurrentSC = sc.calculate_spectral_current_sc(sc.Material.BandGap, sc.Structure.AbsorptionResults);
      sc.SpectralCurrentSC = Monitor('current', sc.Structure.AbsorptionResults.Frequency, spectralCurrentSC);
      sc.CurrentSC = trapz(sc.SpectralCurrentSC.Energy, sc.SpectralCurrentSC.Data);
      
     
      % 948 is highest index == 1
%       ind = find(sc.SolarSpectrum.Energy >=sc.Material.BandGap);
%       currentSC = -Constants.LightConstants.Q*...
%         trapz(sc.SolarSpectrum.Energy(ind),...
%         sc.SolarSpectrum.PhotonFlux(ind));

    end
    
%     function sc = runSQSimulation(sc)
%       %disp('Simulating SQ');
%       sc.SQSimulation = ShockleyQueisser(sc.SolarSpectrum, sc.Structure, sc.CurrentSC);
%     end
    
    
    function reflectionIntegrated = get.ReflectionIntegrated(sc)      
      reflectionIntegrated = ...
        SolarCell.calculate_integrated_data(sc.SolarSpectrum,...
        sc.Structure.ReflectionResults.Energy,...
        sc.Structure.ReflectionResults.Data); 
    end
    
    function transmissionIntegrated = get.TransmissionIntegrated(sc)      
      transmissionIntegrated = ...
        SolarCell.calculate_integrated_data(sc.SolarSpectrum,...
        sc.Structure.TransmissionResults.Energy,...
        sc.Structure.TransmissionResults.Data); 
    end
%     
%     function absorptionIntegrated = get.AbsorptionIntegrated(sr)      
%       absorptionIntegrated = ...
%         calculate_integrated_data(sr,sr.AbsorptionResults.Energy,...
%         sr.AbsorptionResults.Data); 
%     end

        
    function absorptionIntegrated = get.AbsorptionIntegrated(sc)      
      absorptionIntegrated = ...
        SolarCell.calculate_integrated_data(sc.SolarSpectrum,...
          sc.Structure.AbsorptionResults.Energy,...
          sc.Structure.AbsorptionResults.Data); 
    end
    %
    %     function limitingEfficiency = get.LimitingEfficiency(sc)
    %       limitingEfficiency = sc.SQSimulation.LimitingEfficiency;
    %     end
    %
    %     function limitingEfficiencyDetailed = get.LimitingEfficiencyDetailed(sc)
    %     % This is too much;
    %       limitingEfficiencyDetailed =...
    %         sc.SQSimulation.DetailedSimulationResults.LimitingEfficiencyDetailed;
    %     end

    function adjust_for_theta(sc, theta)
      % note that theta is in degrees
      sc.UltimateEfficiency = sc.UltimateEfficiency*cos(degtorad(theta));
      sc.CurrentSC = sc.CurrentSC*cos(degtorad(theta));
      sc.SpectralCurrentSC.Data = sc.SpectralCurrentSC.Data*cos(degtorad(theta));
    end

%     function ultimateEfficiency = get.UltimateEfficiency(sc)   
%       ultimateEfficiency = SolarCell.calculate_ultimate_efficiency(sc.SolarSpectrum,...  
%         sc.Material.BandGap, sc.Structure.AbsorptionResults);
%     end
    
%     function set.UltimateEfficiency(sc, ue)
%       sc.UltimateEfficiency = ue;
%     end
%             
%     function currentSC = get.CurrentSC(obj)
%       %currentSC = sc.calculate_current_sc(sc.Material.BandGap, sc.Structure.AbsorptionResults);
% %      currentSC = sc.calculate_current_sc();
%       currentSC = -trapz(obj.SpectralCurrentSC.Energy, obj.SpectralCurrentSC.Data);
%     end  
    
%     function SpectralCurrentSC = get.SpectralCurrentSC(sc)
%       spectralCurrentSC = sc.calculate_spectral_current_sc(sc.Material.BandGap, sc.Structure.AbsorptionResults);
%       SpectralCurrentSC = Monitor('current', sc.Structure.AbsorptionResults.Frequency, spectralCurrentSC);
%     end
    
  end

  methods(Static)
    test();
    
    test2();
    
    ultimateEfficiency = calculate_ultimate_efficiency(spectrum,...
      bandGap, absorptionResults)
    
    
    [dataIntegrated, warning] = calculate_integrated_data(SS,energy,data)
    %CALCULATE_INTEGRATED_DATA
    % Calculates the integrated data over the spectrum
    % 
    % Copyright 2011
    % Paul W. Leu 
    % LAMP, University of Pittsburgh
    
  end
end


