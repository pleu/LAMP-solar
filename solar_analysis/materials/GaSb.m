classdef GaSb < MaterialType
% GaSb
% 

  properties
    BandGap = 0.7;
  end
  
  methods
    function s = GaSb()
      s = s@MaterialType('GaSb');
    end
      
    
  end
  
end


