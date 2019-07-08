classdef InSb < MaterialType
% Si 
% 

  properties
    BandGap = 0.17;
    OpticalProperties = OpticalProperties('InSb');
  end
  
  methods
    function s = InSb()
      s = s@MaterialType('InSb');
    end
      
    
  end
  
end


