classdef Ag < MaterialType
  %UNTITLED35 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Rho = 1.58e-8;  % in units of Ohm-m
    OpticalProperties;
  end
  
  methods
    
    function s = Ag()
      s = s@MaterialType('Ag');
      s.OpticalProperties = OpticalProperties('Ag');
    end
        
  end
  
end

