classdef Ni < MaterialType
    %NI Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Rho = 6.93e-8;  % in units of Ohm-m
    end
    
  methods
    
    function s = Ni()
      s = s@MaterialType('Ni');
    end
        
  end
    
end

