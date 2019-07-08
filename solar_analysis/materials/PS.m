classdef PS < MaterialType
% PS
% 

  properties
    OpticalProperties;
  end
  
  methods
    function s = PS()
      s = s@MaterialType('PS');
      s.OpticalProperties = OpticalProperties('PS (FDTD)');
    end
     
  end
  
end


