classdef Au < MaterialType
  %UNTITLED35 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Rho = 2.21e-8;  % in units of Ohm-m
    OpticalProperties;
  end
  
  methods
    
    function s = Au()
      s = s@MaterialType('Au');
      s.OpticalProperties = OpticalProperties('Au');
    end
        
  end
  
end