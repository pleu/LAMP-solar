classdef Nanomesh < FDTDSimulationResults
% FDTDSIMULATIONRESULTS class for FDTD Simulation Results
% 
% Input
% Filename - Filename of results
% SS       - SolarSpectrum 
% Shape       - MaterialData
% IndependentVariable - either Frequency (default) or Wavelength
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh
  properties
    Pitch;
    Shape;
  end
  
  properties (Dependent = true)
    Area;
  end
    
  methods
    function sr = Nanomesh(filename, independentVariableType, pitch, shape)
      %sr = FDTDSimulationResults.empty(length(filename), 0);
      %for i = 1:length(filename)
      sr = sr@FDTDSimulationResults(filename, independentVariableType);
      %end
      sr.Shape = shape;
      sr.Pitch = pitch;
    end
  
    function area = get.Area(sr)
      area = sr.Shape.Area;
    end
  
  end
  
  methods(Static)
    sr = create_array(filename, independentVariableType, pitch, shape);
  end  
    
end

