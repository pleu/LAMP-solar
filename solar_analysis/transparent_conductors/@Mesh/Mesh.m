classdef Mesh < Shape
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Diameter;
%     Pitch;
    Thickness;
  end
  
  properties(Dependent = true)
    Area;
  end
  
  methods
    function shape = Mesh(thickness, diameter)
%      shape = shape.ShapeType('Circle');
      shape.Diameter = diameter;
%       shape.Pitch = pitch;
      shape.Thickness = thickness;
    end
    
    function area = get.Area(shape)
      area = shape.Diameter * shape.Thickness; %dummy variable
    end
    
    function [shape] = set.Area(shape, area)
      shape.Diameter = sqrt(4*area)/pi;
    end
  end
  
  methods(Static)
    function [ca] = create_array(thicknesses, diameters)
      ca = Mesh.empty(length(diameters), 0);
      for i = 1:length(diameters)
        ca{i} = Mesh(thicknesses(i),diameters(i));
      end
    end
    
    test
  end
  
end

