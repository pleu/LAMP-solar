classdef PEC < MaterialType
% PEC
% 

  properties
    OpticalProperties;
  end
  
  methods
    function s = PEC()
      s = s@MaterialType('PEC');
      s.OpticalProperties = OpticalProperties('PEC');
    end
      
    
  end
  
end


