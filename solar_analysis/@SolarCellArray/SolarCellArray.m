classdef SolarCellArray < SimulationArray 
  properties
    SolarCells;
  end

  properties(Dependent)
    Absorption;
    Reflection;
    Transmission;
    UltimateEfficiency;
    CurrentSC;
    SpectralCurrentSC; 
  end
  
  methods(Access = protected)
    function sca = SolarCellArray(solarCells,...
      variableArray)
      sca.SolarCells = solarCells;
      sca.VariableArray = variableArray;
    end
  end
  
  methods
    function absorption = get.Absorption(tca)
      absorption = [tca.SolarCells.AbsorptionIntegrated];
    end
    
    function reflection = get.Reflection(tca)
      reflection = [tca.SolarCells.ReflectionIntegrated];
    end
    
    function transmission = get.Transmission(tca)
      transmission = [tca.SolarCells.TransmissionIntegrated];
    end
    
    function ultimateEfficiency = get.CurrentSC(tca)
      ultimateEfficiency = [tca.SolarCells.CurrentSC];
    end
    
    function ultimateEfficiency = get.UltimateEfficiency(tca)
      ultimateEfficiency = [tca.SolarCells.UltimateEfficiency];
    end
    
    function spectralcurrentSC = get.SpectralCurrentSC(tca)
      spectralcurrentSC = [tca.SolarCells.SpectralCurrentSC];
    end


  end
  
  methods(Static)
    [scArray] = create_FDTD(solarSpectrum,...
      variableArray, material, independentVariableType)
    
    [scArray] = create(solarSpectrum,...
      sr, variableArray, material)
    
    test();
    
    test2();

  end

  
end

