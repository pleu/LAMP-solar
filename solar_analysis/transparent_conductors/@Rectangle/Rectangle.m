classdef Rectangle < Shape
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Length;
    Width;
  end
  
  properties (Dependent = true)
    Area;
  end
  
  methods
    function shape = Rectangle(length, width)
      shape.Length = length;
      shape.Width = width;
    end
    
    function area = get.Area(shape)
      area = shape.Length * shape.Width;
    end
  end
  
  methods(Static)
    function [ra] = create_array(lengths,widths)
      ra = Rectangle.empty(length(lengths), 0);
      for i = 1:length(lengths)
        ra{i} = Rectangle(lengths(i),widths(i));
      end
    end
    
    test
  end
  
end
