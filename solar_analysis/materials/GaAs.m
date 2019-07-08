classdef GaAs < MaterialType
% GaAs
% 

  properties
    BandGap = 1.43;
    OpticalProperties = OpticalProperties('GaAs');
  end
  
  methods
    function s = GaAs()
      s = s@MaterialType('GaAs');
    end
      
    
  end
  
end


