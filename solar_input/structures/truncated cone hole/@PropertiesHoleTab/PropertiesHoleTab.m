classdef PropertiesHoleTab < handle

  properties
    X;
    Y;
    Z;
    IndexType;
    IndexValue;
    MaterialType;
    MaterialValue;
    RTopType;
    RTopValue;
    RBottomType;
    RBottomValue;        
    ZSpanType;
    ZSpanValue;
    Area;
    Volume;
  end

  % Maybe we need to create a new function which we can use to create
  % objects (like index, material...) in properties tab and edit the
  % types and value of them. 

  methods
    function obj = PropertiesHoleTab(zspan, rtop, rbottom)
      if nargin == 0
        obj.X = 0;
        obj.Y = 0;
        obj.Z = 0;
        obj.IndexType = 'Number';
        obj.IndexValue = 1;
        obj.MaterialType = 'Material';
        obj.MaterialValue = 'etch';
        obj.RTopType = 'Length';
        obj.RTopValue = 0.1e-6;  % in micron
        obj.RBottomType = 'length';
        obj.RBottomValue = 0.2e-6; % in micron
        obj.ZSpanType = 'Length';
        obj.ZSpanValue = 0.5e-6; % in micron
      elseif nargin == 2
        obj.X = 0;
        obj.Y = 0;
        obj.Z = 0;
        obj.IndexType = 'Number';
        obj.IndexValue = 1;
        obj.MaterialType = 'Material';
        obj.MaterialValue = 'etch';
        obj.RTopType = 'Length';
        obj.RTopValue = rtop;  
        obj.RBottomType = 'length';
        obj.RBottomValue = rtop; 
        obj.ZSpanType = 'Length';
        obj.ZSpanValue = zspan;
      elseif nargin == 3
        obj.X = 0;
        obj.Y = 0;
        obj.Z = 0;
        obj.IndexType = 'Number';
        obj.IndexValue = 1;
        obj.MaterialType = 'Material';
        obj.MaterialValue = 'etch';
        obj.RTopType = 'Length';
        obj.RTopValue = rtop;  
        obj.RBottomType = 'length';
        obj.RBottomValue = rbottom; 
        obj.ZSpanType = 'Length';
        obj.ZSpanValue = zspan;
      end
    end
     
    function Area = get.Area(obj)
      Area = pi*(obj.RTopValue^2+obj.RTopValue*obj.RBottomValue+obj.RBottomValue^2)/3;
    end
    
    function Volume = get.Volume(obj)
      Volume = obj.Area*obj.ZSpanValue;
    end

  end
    
  methods(Static)
    test();
  end
end