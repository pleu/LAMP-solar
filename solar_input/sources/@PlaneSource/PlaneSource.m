classdef PlaneSource
%PLANESOURCE Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    FrequencyWavelength;
    BeamOptions;
  end

  properties(Dependent)
    Geometry;
  end

  
  methods
    function obj = PlaneSource()
      if nargin == 0
        % Default values
        obj.General = PlaneGeneralTab();
        obj.FrequencyWavelength = FrequencyTab();
        obj.BeamOptions = BeamOptionsTab();
      end
    end
    
    function geometry = get.Geometry(obj)
      geometry = obj.General.Geometry;
    end
    
  end
  
  methods(Static) 
    test();
  end
  
end

