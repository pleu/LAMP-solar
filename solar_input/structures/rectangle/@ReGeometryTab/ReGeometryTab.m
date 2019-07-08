classdef ReGeometryTab < handle
  %GEOMETRY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Volume;
    Area;
  end
  
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



  properties(Access = 'private')
    xCoordinates; % Coordinates object
    yCoordinates; % Coordinates object
    zCoordinates; % Coordinates object
%    InjectionAxisOptions = {'x-axis', 'y-axis', 'z-axis'};
%   InjectionAxisPrivate; % just a private storage
  end
  
%   properties(Dependent,Hidden=true)
%     InjectionAxis;
%   end
  
  methods
    function obj = ReGeometryTab()
      obj.xCoordinates = Coordinates();
      obj.yCoordinates = Coordinates();
      obj.zCoordinates = Coordinates();
%     if nargin == 1
%       obj.InjectionAxis = injectionAxis;
%       else
%      obj.InjectionAxis = 'z-axis';
%       end
    end
    
%     function injectionAxis = get.InjectionAxis(obj)
%       injectionAxis = obj.InjectionAxisPrivate;
%     end
    
%     function set.InjectionAxis(obj, injectionAxis)
%       index = get_index_from_list(obj.InjectionAxisOptions, injectionAxis);
%       if index == 1
%         obj.xCoordinates = Coordinates();
%       elseif index == 2
%         obj.yCoordinates = Coordinates();        
%       else
%         obj.zCoordinates = Coordinates();
%       end
%       
%       obj.InjectionAxisPrivate = set_value_from_list(obj.InjectionAxisOptions, injectionAxis);      
%       index = get_index_from_list(obj.InjectionAxisOptions, injectionAxis);
%       if index == 1
%         obj.xSpan = 0;
%       elseif index == 2
%         obj.ySpan = 0;
%       else
%         obj.zSpan = 0;
%       end
%     end

    function x = get.X(obj)
      x = obj.xCoordinates.Center;
    end

    function xSpan = get.XSpan(obj)
      xSpan = obj.xCoordinates.Span;
    end
    
    function xMin = get.XMin(obj)
      xMin = obj.xCoordinates.Min;
    end

    function xMax = get.XMax(obj)
      xMax = obj.xCoordinates.Max;
    end
    
    function y = get.Y(obj)
      y = obj.yCoordinates.Center;
    end

    function ySpan = get.YSpan(obj)
      ySpan = obj.yCoordinates.Span;
    end

    function yMin = get.YMin(obj)
      yMin = obj.yCoordinates.Min;
    end

    function yMax = get.YMax(obj)
      yMax = obj.yCoordinates.Max;
    end

    function z = get.Z(obj)
      z = obj.zCoordinates.Center;
    end
    
    function zSpan = get.ZSpan(obj)
      zSpan = obj.zCoordinates.Span;
    end
    
    function Area = get.Area(obj)
      Area = obj.XSpan*obj.YSpan;
    end
    
    function Volume = get.Volume(obj)
      Volume = obj.XSpan*obj.YSpan*obj.ZSpan;
    end

    function zMin = get.ZMin(obj)
      zMin = obj.zCoordinates.Min;
    end

    function zMax = get.ZMax(obj)
      zMax = obj.zCoordinates.Max;
    end

    function set.X(obj, x)
      obj.xCoordinates.Center = x;
    end
    
    function set.XSpan(obj, xSpan)
        obj.xCoordinates.Span = xSpan;      
    end
 
    function set.XMin(obj, xMin)
      obj.xCoordinates.Min = xMin;
    end
 
    function set.XMax(obj, xMax)
      obj.xCoordinates.Max = xMax;
    end
    
    function set.Y(obj, y)
      obj.yCoordinates.Center = y;
    end
    
    function set.YSpan(obj, ySpan)
        obj.yCoordinates.Span = ySpan;      
    end
 
    function set.YMin(obj, yMin)
      obj.yCoordinates.Min = yMin;
    end
 
    function set.YMax(obj, yMax)
      obj.yCoordinates.Max = yMax;
    end

    function set.Z(obj, z)
      obj.zCoordinates.Center = z;
    end
    
    function set.ZSpan(obj, zSpan)
        obj.zCoordinates.Span = zSpan;      
    end
 
    function set.ZMin(obj, zMin)
      obj.zCoordinates.Min = zMin;
    end
 
    function set.ZMax(obj, zMax)
      obj.zCoordinates.Max = zMax;
    end

  end
  
  
  
  methods(Static)
    test();
  end
  
end

