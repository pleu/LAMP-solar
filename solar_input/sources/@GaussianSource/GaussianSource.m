classdef GaussianSource
  %GAUSSIANSOURCE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    General;
    Geometry;
    FrequencyWavelength;
    BeamOptions;
  end
  
  methods
    function obj = GaussianSource()
      if nargin == 0
        % Default values
        obj.General = GaussianGeneralTab();
        obj.Geometry = GeometryTab();
      end
    end
  end
  
  methods(Static) 
    test();
  end
  
end

