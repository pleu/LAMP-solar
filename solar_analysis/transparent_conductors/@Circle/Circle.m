classdef Circle < Shape
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Diameter;
  end
  
  properties (Dependent = true)
    Area;
  end
  
  methods
    function shape = Circle(diameter)
%      shape = shape.ShapeType('Circle');
      shape.Diameter = diameter;
    end
    
    function area = get.Area(shape)
      area = pi * shape.Diameter^2 / 4;
    end
    
    function [shape] = set.Area(shape, area)
      shape.Diameter = sqrt(4*area)/pi;
    end
  end
  
  methods(Static)
    function [ca] = create_array(diameters)
      ca = Circle.empty(length(diameters), 0);
      for i = 1:length(diameters)
        ca{i} = Circle(diameters(i));
      end
    end
    
    test
  end
  
end

