classdef OneDArray < handle
  %ONEDDIFFRACTIONSTRUCTREU Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Pitch@double;     % in nm
    Number@double;
  end
  
  methods
    function set.Number(obj, value)
      if mod(value,1) == 0 || isinf(value)      % isinteger(value)
        obj.Number = value;
      else
        error('Number must be an integer or inf');
      end
    end
    
    function set.Pitch(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.Pitch = value;
      end
    end
    
  end
  
end

