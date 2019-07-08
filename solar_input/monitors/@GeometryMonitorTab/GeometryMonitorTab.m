classdef GeometryMonitorTab < handle & matlab.System
  %GEOMETRY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    MonitorType;  % 1: Point, 2: Linear X, 3: Lineary Y, 
                  % 4: Linear Z, 5: 2D X-normal, 6: 2D Y-nomral, 
                  % 7: 2D Z-normal, 8: 3D
    DownSampleX;
    DownSampleY;
    DownSampleZ;
    OffSet;

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
    XCoordinates; % Coordinates object
    YCoordinates; % Coordinates object
    ZCoordinates; % Coordinates object
  end
  
  methods(Access = protected)
    function flag = isInactivePropertyImpl(obj,propertyName)
      if strcmp('MonitorType', propertyName)
        flag = false;
      else
        if getnameidx({'X', 'Y', 'Z', 'OffSet'}, propertyName)
            flag = false;
        elseif strcmp(obj.MonitorType, 'Linear X')
          if getnameidx({'XSpan', 'XMin', 'XMax', 'DownSampleX'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, 'Linear Y')
          if getnameidx({'YSpan', 'YMin', 'YMax', 'DownSampleY'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, 'Linear Z')
          if getnameidx({'ZSpan', 'ZMin', 'ZMax', 'DownSampleZ'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, '2D X-normal')
          if getnameidx({'YSpan', 'YMin', 'YMax', 'DownSampleY', 'ZSpan', 'ZMin', 'ZMax', 'DownSampleZ'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, '2D Y-normal')
          if getnameidx({'XSpan', 'XMin', 'XMax', 'DownSampleX', 'ZSpan', 'ZMin', 'ZMax', 'DownSampleZ'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, '2D Z-normal')
          if getnameidx({'XSpan', 'XMin', 'XMax', 'DownSampleX', 'YSpan', 'YMin', 'YMax', 'DownSampleY'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        elseif strcmp(obj.MonitorType, '3D')
          if getnameidx({'XSpan', 'XMin', 'XMax', 'DownSampleX', 'YSpan', 'YMin', 'YMax', 'DownSampleY', 'ZMin',...
                  'ZMax', 'ZSpan', 'DownSampleZ'}, propertyName)
            flag = false;
          else
            flag = true;
          end
        else 
          flag = true;
        end
      end
    end
  end

  
  methods   
    function obj = GeometryMonitorTab(varargin)
      if nargin == 0
        obj.MonitorType = '2D Z-normal';
        obj.XCoordinates = Coordinates();
        obj.YCoordinates = Coordinates();
        obj.ZCoordinates = Coordinates();
        obj.DownSampleX = 1;
        obj.DownSampleY = 1;
        obj.DownSampleZ = 1;
        obj.OffSet = 200e-9;
      end
    end
    
    function set.MonitorType(obj, simulationType)
      options = {'Point', 'Linear X', 'Linear Y', 'Linear Z', '2D X-normal', '2D Y-normal', '2D Z-normal', '3D'};
      obj.MonitorType = set_value_from_list(options, simulationType);
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

    function ySpan = get.YSpan(obj)
      ySpan = obj.YCoordinates.Span;
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
    
    function zSpan = get.ZSpan(obj)
      zSpan = obj.ZCoordinates.Span;
    end

    function zMin = get.ZMin(obj)
      zMin = obj.ZCoordinates.Min;
    end

    function zMax = get.ZMax(obj)
      zMax = obj.ZCoordinates.Max;
    end
    
    function offSet = get.OffSet(obj)
      offSet = obj.OffSet;
    end

    function set.X(obj, x)
      obj.XCoordinates.Center = x;
    end
    
    function set.XSpan(obj, xSpan)
      obj.XCoordinates.Span = xSpan;
    end
 
    function set.XMin(obj, xMin)
      obj.XCoordinates.Min = xMin;
    end
 
    function set.XMax(obj, xMax)
      obj.XCoordinates.Max = xMax;
    end

    
    function set.Y(obj, y)
      obj.YCoordinates.Center = y;
    end
    
    function set.YSpan(obj, ySpan)
      obj.YCoordinates.Span = ySpan;
    end
 
    function set.YMin(obj, yMin)
      obj.YCoordinates.Min = yMin;
    end
 
    function set.YMax(obj, yMax)
      obj.YCoordinates.Max = yMax;
    end

    function set.Z(obj, z)
      obj.ZCoordinates.Center = z;
    end
    
    function set.ZSpan(obj, ySpan)
      obj.ZCoordinates.Span = ySpan;
    end
 
    function set.ZMin(obj, zMin)
      obj.ZCoordinates.Min = zMin;
    end
 
    function set.ZMax(obj, zMax)
      obj.ZCoordinates.Max = zMax;
    end
    
    function set.OffSet(obj, offSet)
      obj.OffSet = offSet;
    end

    
  end
  
  
  
  methods(Static)
    test();
  end
  
end
