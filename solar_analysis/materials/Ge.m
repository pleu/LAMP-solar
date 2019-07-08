classdef Ge < MaterialType
% Ge
% 

  properties
    BandGap = 0.67;
    OpticalProperties = OpticalProperties('Ge');
  end
  
  methods
    function s = Ge()
      s = s@MaterialType('Ge');
    end
      
    
  end
  
end


