classdef SiO2 < MaterialType
% Si 
% 

  properties
    BandGap = 9;
    OpticalProperties = OpticalProperties('SiO2glass');
  end
  
  methods
    function s = SiO2()
      s = s@MaterialType('SiO2');
    end
      
    
  end
  
end


