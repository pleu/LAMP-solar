classdef TruncatedConeHole < handle
% TRUNCATEDCONEHOLE 
%
  properties
    Properties;
    Script;
    Rotations;
  end

%   properties(Dependent)
%     Material;
%     RTopValue;
%     RBottomValue;
%     ZSpanValue;
%   end

  
  methods
    function obj = TruncatedConeHole(zspan, rtop, rbottom)
      if nargin == 0
        % Default values
        obj.Properties = PropertiesHoleTab();
        obj.Script = ScriptHoleTab();
        obj.Rotations = RotationsHoleTab();
       elseif nargin == 2
        obj.Properties = PropertiesHoleTab(zspan, rtop);
        obj.Script = ScriptHoleTab();
        obj.Rotations = RotationsHoleTab();
      elseif nargin == 3
        obj.Properties = PropertiesHoleTab(zspan, rtop, rbottom);
        obj.Script = ScriptHoleTab();
        obj.Rotations = RotationsHoleTab();
      end
    end

%     function material = get.Material(obj)
%       material = obj.Properties.MaterialValue;
%     end
% 
%     
%     function rTopValue = get.RTopValue(obj)
%       rTopValue = obj.Properties.RTopValue;
%     end
%     
%     function rBottomValue = get.RBottomValue(obj)
%       rBottomValue = obj.Properties.RBottomValue;
%     end
%     
%     function zSpanValue = get.ZSpanValue(obj)
%       zSpanValue = obj.Properties.ZSpanValue;
%     end
%     
%     function set.RTopValue(obj, rTop)
%       obj.Properties.RTopValue = rTop;
%     end
%     
%     function set.RBottomValue(obj, rBottom)
%       obj.Properties.RBottomValue = rBottom;
%     end
%     
%     function set.ZSpanValue(obj, zSpanValue)
%       obj.Properties.ZSpanValue = zSpanValue;
%     end
% 
%     function set.Material(obj, material)
%       obj.Properties.MaterialValue = material;
%     end

    
  end
  
  methods(Static) 
    test();
  end
  
end