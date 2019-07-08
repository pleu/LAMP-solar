classdef TransparentConductor
% TransparentConductor class for solar cell
%
% Copyright 2011
% Paul Leu 
  properties
    SolarSpectrum;
    Structure; % this must be a single structure
    % FDTD1DArray, TvsRsDataFile
    % Each of these must have sheet resistivity, and transmission results
    Material;
    SheetResistance;       % Sheet resistance in Ohm/Square
                            % for 1D grating we use R_s = rho*a/A;
  end
  properties(Dependent = true)
    NumStructures;         % number of structures for 1 Transparent conductor
    SigmaDCSigmaOP;        % figure of merit for transparent conductors;
                           % the higher the better
    SigmaAlpha;            % in units of Ohm^(-1);
                           % another figure of merit; proposed by 
                           % Gordon 
  end
  
  properties(SetAccess='private')
    AbsorptionIntegrated;   % Structure must include an Absorption Results 
                            % variable
    ReflectionIntegrated;   % Structure must include an Reflection Results 
                            % variable 
    TransmissionIntegrated; % Structure must include an Transmission Results 
                            % variable
    
  end
  
  
  
   
  methods    
    function tc = TransparentConductor(solarSpectrum, structure, material)
      if nargin > 0
        tc.SolarSpectrum = solarSpectrum;
        tc.Structure = structure;
        tc.Material = material;
      
        %tc.Material = MaterialType.create(material);
      end
        tc.AbsorptionIntegrated = tc.calc_absorption_integrated;
        tc.ReflectionIntegrated = tc.calc_reflection_integrated;
        tc.TransmissionIntegrated = tc.calc_transmission_integrated;
        tc.SheetResistance = tc.calc_sheet_resistance;
    end
 
    function numStructures = get.NumStructures(tc)
      numStructures = length(tc.Structure);     
    end
    
    function sheetResistance = calc_sheet_resistance(tc)      
      sheetResistanceArray = zeros(tc.NumStructures, 1);
      for i = 1:tc.NumStructures
        sheetResistanceArray(i) = ...
        Constants.UnitConversions.MtoNM*tc.Material.Rho*...
        tc.Structure(i).Pitch/tc.Structure(i).Area; 
      end
      sheetResistance = mean(sheetResistanceArray);
    end

    function sigmaDCSigmaOP = get.SigmaDCSigmaOP(tc)
      sigmaDCSigmaOP = ...
        Constants.LightConstants.Z0/...
        (2*tc.SheetResistance)*sqrt(tc.TransmissionIntegrated)/(1 - sqrt(tc.TransmissionIntegrated));
%       sigmaDCSigmaOP = ...
%         Constants.LightConstants.Z0/...
%         (2*tc.SheetResistance*(1/sqrt(tc.TransmissionIntegrated)-1));
    end
    
    function sigmaAlpha = get.SigmaAlpha(tc)
      sigmaAlpha = ...
        1/(tc.SheetResistance*tc.AbsorptionIntegrated);
    end

    function transmissionIntegrated = calc_transmission_integrated(tc)      
      transmissionIntegratedArray = zeros(tc.NumStructures, 1);
      for i = 1:tc.NumStructures
        [transmissionIntegratedArray(i), warning] = ...
        SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
        tc.Structure(i).TransmissionResults.Energy,...
        tc.Structure(i).TransmissionResults.Data); 
%         if(warning) 
%           disp(tc.Structure.Filename) 
%         end;
      end
      transmissionIntegrated = mean(transmissionIntegratedArray);
    end
  
    function absorptionIntegrated = calc_absorption_integrated(tc)      
      absorptionIntegratedArray = zeros(tc.NumStructures, 1);
      for i = 1:tc.NumStructures
        [absorptionIntegratedArray(i), warning] = ...
          SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
            tc.Structure(i).AbsorptionResults.Energy,...
            tc.Structure(i).AbsorptionResults.Data); 
%           if(warning) 
%             disp(tc.Structure.Filename) 
%           end;
      end
      absorptionIntegrated = mean(absorptionIntegratedArray);
    end
    
    function reflectionIntegrated = calc_reflection_integrated(tc)      
      reflectionIntegratedArray = zeros(tc.NumStructures, 1);
      for i = 1:tc.NumStructures
        [reflectionIntegratedArray(i), warning] = ...
        SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
        tc.Structure(i).ReflectionResults.Energy,...
        tc.Structure(i).ReflectionResults.Data); 
%         if(warning) 
%           disp(tc.Structure.Filename) 
%         end;
      end
      reflectionIntegrated = mean(reflectionIntegratedArray);        
    end
    
  end
  
  methods(Static)
    test();
    
    test2();
    
    plot_constant_sheet_resistance();
    
    [Rs] = calc_sheet_resistance_from_fom(sigmaDCSigmaOP, transmission);
    
    [fom] = calc_fom(sheet_resistance, transmission);
    
    [df] = read_diffusive_specular_data(filename);
  end

end

