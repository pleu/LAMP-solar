classdef Rotations < handle
    
    properties
        Axis;
        Rotation;
    end
    
    methods
        function obj = Rotations(axis, rotation)
            if nargin == 0
                obj.Axis = 'none';
                obj.Rotation = 0;
            else
                obj.Axis = axis;
                if strcmp(axis, 'none')
                    obj.Rotation = 0;
                else
                    obj.Rotation = rotation;
                end
            end
        end
        
    end
    
    methods(Static)
        test();
    end
end