classdef GeometryFDTDTab < handle
  %GEOMETRY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties(Dependent)
    X;
    XSpan;
    XMin;
    XMax;
    Y;
    YSpan;
    YMin;
    YMax;
    Z;
    ZSpan;
    ZMin;
    ZMax;
  end
  
  properties
    Area;
    OffSet;
  end

  properties(Access = 'private')
    XCoordinates; % Coordinates object
    YCoordinates; % Coordinates object
    ZCoordinates; % Coordinates object
  end
  
  methods
    function obj = GeometryFDTDTab()
      obj.XCoordinates = Coordinates();
      obj.YCoordinates = Coordinates();
      obj.ZCoordinates = Coordinates();
      obj.OffSet = 300e-9;
    end

    function x = get.X(obj)
      x = obj.XCoordinates.Center;
    end

    function xSpan = get.XSpan(obj)
      xSpan = obj.XCoordinates.Span;
    end
    
    function xMin = get.XMin(obj)
      xMin = obj.XCoordinates.Min;
    end

    function xMax = get.XMax(obj)
      xMax = obj.XCoordinates.Max;
    end
    
    function y = get.Y(obj)
      y = obj.YCoordinates.Center;
    end

    function YSpan = get.YSpan(obj)
      YSpan = obj.YCoordinates.Span;
    end

    function yMin = get.YMin(obj)
      yMin = obj.YCoordinates.Min;
    end

    function yMax = get.YMax(obj)
      yMax = obj.YCoordinates.Max;
    end

    function z = get.Z(obj)
      z = obj.ZCoordinates.Center;
    end
    
    function ZSpan = get.ZSpan(obj)
      ZSpan = obj.ZCoordinates.Span;
    end

    function zMin = get.ZMin(obj)
      zMin = obj.ZCoordinates.Min;
    end

    function zMax = get.ZMax(obj)
      zMax = obj.ZCoordinates.Max;
    end
    
%     function Area = get.Area(obj)
%       Area = obj.XCoordinates.Span*(obj.YCoorinates.Span);
%     end
    
    function Area = get.Area(obj)
      Area = obj.XSpan*(obj.YSpan);
    end
    
    function offSet = get.OffSet(obj)
      offSet = obj.OffSet;
    end
    
    function set.X(obj, x)
      obj.XCoordinates.Center = x;
    end

    function set.XMin(obj, xMin)
      obj.XCoordinates.Min = xMin;
    end
 
    function set.XMax(obj, xMax)
      obj.XCoordinates.Max = xMax;
    end
    
    function set.XSpan(obj, xSpan)
      obj.XCoordinates.Span = xSpan;
    end
    
    function set.Y(obj, y)
      obj.YCoordinates.Center = y;
    end
 
    function set.YMin(obj, yMin)
      obj.YCoordinates.Min = yMin;
    end
 
    function set.YMax(obj, yMax)
      obj.YCoordinates.Max = yMax;
    end
    
    function set.YSpan(obj, ySpan)
      obj.YCoordinates.Span = ySpan;
    end    

    function set.Z(obj, z)
      obj.ZCoordinates.Center = z;
    end
    
    function set.ZMin(obj, zMin)
      obj.ZCoordinates.Min = zMin;
    end
 
    function set.ZMax(obj, zMax)
      obj.ZCoordinates.Max = zMax;
    end
    
    function set.ZSpan(obj, zSpan)
      obj.ZCoordinates.Span = zSpan;
    end
    
    function set.OffSet(obj, offSet)
      obj.OffSet = offSet;
    end
  end
  
  
  
  methods(Static)
    test();
  end
  
end

