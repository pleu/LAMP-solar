classdef TransparentConductorAvg
% TransparentConductor class takes average betwen several files for solar cell
%
% Copyright 2011
% Paul Leu 
  properties
    SolarSpectrum;
    Structure; % this must be a single structure
    % FDTD1DArray, FDTDThinFilm, DataFile
    % Each of these must have sheet resistivity, and transmission results
    Material;
  end
  properties(Dependent = true)
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
    SheetResistance;       % Sheet resistance in Ohm/Square
                            % for 1D grating we use R_s = rho*a/A;
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
 
    function sheetResistance = calc_sheet_resistance(tc)      
      sheetResistance = ...
        Constants.UnitConversions.MtoNM*tc.Material.Rho*...
        tc.Structure.Pitch/tc.Structure.Area; 
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
      [transmissionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
        tc.Structure.TransmissionResults.Energy,...
        tc.Structure.TransmissionResults.Data); 
      if(warning) 
        disp(tc.Structure.Filename) 
      end;
    end
  
    function absorptionIntegrated = calc_absorption_integrated(tc)      
      [absorptionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
          tc.Structure.AbsorptionResults.Energy,...
          tc.Structure.AbsorptionResults.Data); 
        if(warning) 
          disp(tc.Structure.Filename) 
        end;
    end
    
    function reflectionIntegrated = calc_reflection_integrated(tc)      
      [reflectionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(tc.SolarSpectrum,...
        tc.Structure.ReflectionResults.Energy,...
        tc.Structure.ReflectionResults.Data); 
      if(warning) 
        disp(tc.Structure.Filename) 
      end;
    end
    
  end
  
  methods(Static)
    test();
    
    plot_constant_sheet_resistance();
  end

end



