classdef PbS < MaterialType
% Si 
% 

  properties
    BandGap = 0.37;
  end
  
  methods
    function s = PbS()
      s = s@MaterialType('PbS');
    end
      
    
  end
  
end


