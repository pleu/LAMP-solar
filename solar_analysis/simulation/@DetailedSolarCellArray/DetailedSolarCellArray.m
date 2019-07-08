classdef DetailedSolarCellArray < SimulationArray
  %DETAILEDSOLARCELLARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    SolarCells
  end
  
  properties(Dependent)
    LimitingEfficiency;
  end
  
  methods(Access = protected)
    function sca = DetailedSolarCellArray(solarCells,...
      variableArray)
      sca.SolarCells = solarCells;
      sca.VariableArray = variableArray;
    end
  end

  methods
    function limitingEfficiency = get.LimitingEfficiency(tca)
      limitingEfficiency = [tca.SolarCells.LimitingEfficiency];
    end
  end
    
  methods(Static)
    [tcArray] = create(solarSpectrum,...
      variableArray, material, independentVariableType, thetaE, internalFluorescence)  
    
    test;
    test2;
  end
  
end

