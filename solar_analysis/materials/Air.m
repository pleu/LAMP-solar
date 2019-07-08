classdef Air < MaterialType
  properties
    OpticalProperties;
  end
  
  methods 
    
    function s = Air()
      s = s@MaterialType('Air');
      s.OpticalProperties = OpticalProperties('Air');
    end
        
  end
  
end

