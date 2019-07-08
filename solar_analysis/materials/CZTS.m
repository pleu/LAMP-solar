classdef CZTS < MaterialType
% Si 
% 

  properties
    BandGap = 1.28;
    % from Guangyong Li's paper
  end
  
  methods
    function s = CZTS()
      s = s@MaterialType('CZTS');
    end
      
    
  end
  
end


