classdef BoundaryCondition < handle
    properties
        MinBc;
        MaxBc;
    end
    
    methods(Access = protected)
        function flag = isInactivePropertyImpl(obj, propertyName)
            if strcmp(obj.MinBc, {'Periodic', 'Bloch'})
                if getnameidx('MaxBc', propertyName)
                    flag = true;
                else
                    flag = false;
                end
            end
        end
    end
         
    methods
        function obj = BoundaryCondition(minBc, maxBc)
            if nargin == 0
                obj.MinBc = 'Periodic';
                obj.MaxBc = 'Periodic';
            else
                obj.MinBc = minBc;
                obj.MaxBc = maxBc;
            end
        end
    end
    
    methods(Static)
        test();
    end
end