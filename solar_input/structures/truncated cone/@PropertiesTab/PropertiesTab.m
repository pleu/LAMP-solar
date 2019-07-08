classdef PropertiesTab < handle

  properties
    x;
    y;
    z;
%     IndexName;
    IndexType;
    IndexValue;
%     MaterialName;
    MaterialType;
    MaterialValue;
%     ThetaName;
    rTopType;
    rTopValue;
    rBottomType;
    rBottomValue;        
%     zSpan;
    zSpanType;
    zSpanValue;
    Volume;
  end

  % Maybe we need to create a new function which we can use to create
  % objects (like index, material...) in properties tab and edit the
  % types and value of them. 

  methods
    function obj = PropertiesTab(rtop,rbottom, zspan)
      if nargin == 0
        obj.x = 0;
        obj.y = 0;
        obj.z = 0;
        obj.IndexType = 'Number';
        obj.IndexValue = 1.4;
        obj.MaterialType = 'Material';
        obj.MaterialValue = 'Si (Silicon) - Palik';
        obj.rTopType = 'Length';
        obj.rTopValue = 0.1e-6;  % in micron
        obj.rBottomType = 'length';
        obj.rBottomValue = 0.2e-6; % in micron
        obj.zSpanType = 'Length';
        obj.zSpanValue = 0.5e-6; % in micron
      else
        obj.x = 0;
        obj.y = 0;
        obj.z = 0;
        obj.IndexType = 'Number';
        obj.IndexValue = 1.4;
        obj.MaterialType = 'Material';
        obj.MaterialValue = 'Si (Silicon) - Palik';
        obj.rTopType = 'Length';
        obj.rTopValue = rtop;  
        obj.rBottomType = 'length';
        obj.rBottomValue = rbottom; 
        obj.zSpanType = 'Length';
        obj.zSpanValue = zspan;
      end
    end

    function Volume = get.Volume(obj)
      Volume = pi*(obj.RTopValue^2+obj.RTopValue*obj.RBottomValue+obj.RBottomValue^2)/3*obj.ZSpanValue;
    end
  end
    
  methods(Static)
    test();
  end
end