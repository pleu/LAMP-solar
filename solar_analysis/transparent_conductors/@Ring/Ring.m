classdef Ring
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    OuterRadius;
    InnerRadius;
  end
  
  properties (Dependent = true)
    Area;
  end
  
  methods
    function shape = Ring(outerRadius, innerRadius)
      shape.OuterRadius = outerRadius;
      shape.InnerRadius = innerRadius;
    end
    
    function area = get.Area(shape)
      area = pi * (shape.OuterRadius^2 - shape.InnerRadius^2);
    end
  end
  
end

