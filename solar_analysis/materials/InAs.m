classdef InAs < MaterialType
% GaSb
% 

  properties
    BandGap = 0.354;
  end
  
  methods
    function s = InAs()
      s = s@MaterialType('InAs');
    end
      
    
  end
  
end


