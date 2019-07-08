classdef CircularHole < handle 
  %UNTITLED4 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Diameter@double; % in nm
  end
  
  properties(Hidden)
    Dimensions = 2;
  end
  
  methods
    function obj = CircularHole(diameter)
      obj.Diameter = diameter;
%      obj.Symmetry = 'Cylindrical';
    end

    function set.Diameter(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.Diameter = value;
      end
    end
    
  end
  
  methods(Static)
    test()
  end
  
end

