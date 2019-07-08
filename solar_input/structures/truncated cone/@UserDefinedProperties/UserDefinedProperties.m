classdef UserDefinedProperties < handle
    
    properties
        rTopName;
        rTopType;
        rTopValue;
        rBottomName;
        rBottomType;
        rBottomValue;          
        zSpanName;
        zSpanType;
        zSpanValue;        
        IndexName;
        IndexType;
        IndexValue;
        MaterialName;
        MaterialType;
        MaterialValue;
    end
    
    methods
        function obj = UserDefinedProperties(material, rtop, rbottom, zspan)
            if nargin == 0
                obj.rTopName = 'r top';
                obj.rTopType = 'Length';
                obj.rTopValue = 0.1e-6;
                obj.rBottomName = 'r bottom';
                obj.rBottomType = 'Length';
                obj.rBottomValue = 0.2e-6;          
                obj.zSpanName = 'z span';
                obj.zSpanType = 'Length';
                obj.zSpanValue = 0.5e-6;        
                obj.IndexName = 'Index';
                obj.IndexType = 'Number';
                obj.IndexValue = 1.4;
                obj.MaterialName = 'material';
                obj.MaterialType = 'Material';
                obj.MaterialValue = 'Si (Silicon) - Palik';   
            else
                obj.rTopName = 'r top';
                obj.rTopType = 'Length';
                obj.rTopValue = rtop;
                obj.rBottomName = 'r bottom';
                obj.rBottomType = 'Length';
                obj.rBottomValue = rbottom;          
                obj.zSpanName = 'z span';
                obj.zSpanType = 'Length';
                obj.zSpanValue = zspan;        
                obj.IndexName = 'Index';
                obj.IndexType = 'Number';
                obj.IndexValue = 1.4;
                obj.MaterialName = 'material';
                obj.MaterialType = 'Material';
                obj.MaterialValue =  material;
            end
        end
    end
    
    methods(Static)
        test();
    end
end