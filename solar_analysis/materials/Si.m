classdef Si < MaterialType
% Si 
% 

  properties
    Alpha_FreeCarrier = 5.5e-18;
    AugerCoefficient = 3.88e-31;
    ni = 1.45e10;
    BandGap = 1.12;
    OpticalProperties = OpticalProperties('Si');
  end
  
  methods
    function s = Si()
      s = s@MaterialType('Si');
    end
      
    
  end
  
end


