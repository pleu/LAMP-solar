classdef SpectrophotometerDataArray < SimulationArray
% FDTDSIMULATIONRESULTSARRY class for array of FDTD Simulation Results
% 
% See also FDTDSimulationResults
%
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh   
    
  methods
    function sa = SpectrophotometerDataArray(spectrophotometerData,...
        variableArray)
      if nargin > 0
        sa.Simulations = spectrophotometerData;
        sa.VariableArray = variableArray;
      end
    end
  end
    
  methods(Static)
    %[saArray] = create(variableArray, independentVariableType)
    [saArray, saArrayQuery] = create(variableArray, independentVariableType, thetaQuery)
    
    test();
  end
  
end

