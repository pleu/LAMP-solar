classdef ITO < MaterialType
% Si 
% 

  properties
    OpticalProperties;
  end
  
  methods
    function s = ITO()
      s = s@MaterialType('ITO');
      s.OpticalProperties = OpticalProperties('ITO (FDTD)');
    end
      
    
  end
  
end


