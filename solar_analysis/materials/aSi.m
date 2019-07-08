classdef aSi < MaterialType
% Si 
% 

  properties
    %BandGap = 1.7;
    BandGap = 1.6; % Use this, since there is still some absorption down to this energy
    OpticalProperties = OpticalProperties('a-Si (Silicon) - Palik (FDTD)');
  end
  
  methods
    function s = aSi()
      s = s@MaterialType('aSi');
    end
      
    
  end
  
end


