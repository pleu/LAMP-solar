classdef IntegratedData
  %INTEGRATEDDATA Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Spectrum;
    Structure;
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
    function id = IntegratedData(spectrum, structure)
      if nargin > 0
        if nargin == 2
          id.Spectrum = spectrum;
          id.Structure = structure;
        end
      end
      id.AbsorptionIntegrated = id.calc_absorption_integrated;
      id.ReflectionIntegrated = id.calc_reflection_integrated;
      id.TransmissionIntegrated = id.calc_transmission_integrated;
    end
    
    function transmissionIntegrated = calc_transmission_integrated(id)
      [transmissionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(id.Spectrum,...
        id.Structure.TransmissionResults.Energy,...
        id.Structure.TransmissionResults.Data);
    end
    
    function reflectionIntegrated = calc_reflection_integrated(id)
      [reflectionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(id.Spectrum,...
        id.Structure.ReflectionResults.Energy,...
        id.Structure.ReflectionResults.Data);
    end

    function absorptionIntegrated = calc_absorption_integrated(id)
      [absorptionIntegrated, warning] = ...
        SolarCell.calculate_integrated_data(id.Spectrum,...
        id.Structure.AbsorptionResults.Energy,...
        id.Structure.AbsorptionResults.Data);
    end

    
  end
  
  methods(Static)
    test1();
  end
end

