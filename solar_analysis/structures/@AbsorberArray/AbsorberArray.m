classdef AbsorberArray < SimulationArray
  %ABSORBERARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Absorber
  end
  
  methods
    function obj = AbsorberArray(absorbers, numAbsorbers)
      if nargin ~=0
        obj = AbsorberArray.empty(numAbsorbers, 0);
        for i = 1:numAbsorbers
          obj(i).Absorber = absorbers(i);
        end
      end
      %obj = Absorbers.empty(numAbsorbers, 0);     
    end
    
  end
  
  methods(Static) 
    test();
    
  end
  
end

