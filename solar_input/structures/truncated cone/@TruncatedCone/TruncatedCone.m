classdef TruncatedCone
%PLANESOURCE Summary of this class goes here
%Detailed explanation goes here
  properties
    Properties;
    Script;
    Rotations;
  end

%   properties(Dependent)
%   end

  
  methods
    function obj = TruncatedCone()
      if nargin == 0
        % Default values
        obj.Properties = PropertiesTab();
        obj.Script = ScriptTab();
        obj.Rotations = RotationsTab();
      end
    end
    
%     function geometry = get.Geometry(obj)
%       geometry = obj.General.Geometry;
%     end
    
  end
  
  methods(Static) 
    test();
  end
  
end