classdef Cu < MaterialType
  %UNTITLED35 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Rho = 1.68e-8;  % in units of Ohm-m
    OpticalProperties;
  end
  
  methods
    
    function s = Cu()
      s = s@MaterialType('Cu');
%      s.OpticalProperties = OpticalProperties('Cu');
    end
        
  end
  
end