classdef TransferMatrixSimulationArray < SimulationArray 
  %TRANSFERMATRIXSIMULATIONARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    TransferMatrixSimulations
  end
  
  properties(Dependent)
    TransmissionS;
    ReflectionS;
    AbsorptionS;
  end
  
  methods
    function simulate(tma)
      for i = 1:tma.VariableArray.NumValues
        tma.TransferMatrixSimulations(i).simulate;
      end
    end
    
    function transmissionS = get.TransmissionS(tma)
      transmissionS = [tma.TransferMatrixSimulations.TsIntegrated];
    end
    
    function reflectionS = get.ReflectionS(tma)
      reflectionS = [tma.TransferMatrixSimulations.RsIntegrated];
    end
    
    function absorptionS = get.AbsorptionS(tma)
      absorptionS = [tma.TransferMatrixSimulations.AsIntegrated];
    end

  end
  
  methods(Access = protected)
    function tma = TransferMatrixSimulationArray(transferMatrixSimulations,...
      variableArray)
      tma.TransferMatrixSimulations = transferMatrixSimulations;
      tma.VariableArray = variableArray;
    end
    
   
  end
  
  
  methods(Static)
    function [tma] = create(transferMatrixSimulations, variableArray)
      tma = TransferMatrixSimulationArray(transferMatrixSimulations, variableArray);
    end
    
    test()
  end
end

