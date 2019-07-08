classdef TruncatedConeGeneral < handle & matlab.System
%PLANESOURCE Summary of this class goes here
%Detailed explanation goes here
properties
    Properties;
    Script;
    Rotations;
  end

  properties(Dependent)
    Material;
    RTopValue;
    RBottomValue;
    ZSpanValue;
  end

  
  methods
    function obj = TruncatedConeGeneral(material, rTop, rBottom, zSpan)
      if nargin == 0
        % Default values
        obj.Properties = PropertiesTab();
        obj.Script = ScriptTab();
        obj.Rotations = RotationsTab();
      else
        obj.Properties = PropertiesTab();
        obj.Script = ScriptTab();
        obj.Rotations = RotationsTab();
        obj.Material = material;
        obj.RTopValue = rTop;
        obj.RBottomValue = rBottom;
        obj.ZSpanValue = zSpan;
      end
    end

    function material = get.Material(obj)
      material = obj.Properties.MaterialValue;
    end

    
    function rTopValue = get.RTopValue(obj)
      rTopValue = obj.Properties.RTopValue;
    end
    
    function rBottomValue = get.RBottomValue(obj)
      rBottomValue = obj.Properties.RBottomValue;
    end
    
    function zSpanValue = get.ZSpanValue(obj)
      zSpanValue = obj.Properties.ZSpanValue;
    end
    
    function set.RTopValue(obj, rTop)
      obj.Properties.RTopValue = rTop;
    end
    
    function set.RBottomValue(obj, rBottom)
      obj.Properties.RBottomValue = rBottom;
    end
    
    function set.ZSpanValue(obj, zSpanValue)
      obj.Properties.ZSpanValue = zSpanValue;
    end

    function set.Material(obj, material)
      obj.Properties.MaterialValue = material;
    end

    
  end
  
  methods(Static) 
    test();
  end
  
end