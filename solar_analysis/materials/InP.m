classdef InP < MaterialType
% Si 
% 

  properties
    BandGap = 1.34;
  end
  
  methods
    function s = InP()
      s = s@MaterialType('InP');
    end
      
    
  end
  
end


