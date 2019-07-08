classdef RotationsTab < handle
    properties
        Rotation1_UserDefined = 10;
        Rotation2_UserDefined = 10;
        Rotation3_UserDefined = 10;
        FirstAxis;
        SecondAxis;        
        ThirdAxis;
%     end
%     
%     properties(Dependent)
        Rotation1;
        Rotation2;
        Rotation3;
    end
    
    methods
        function obj = RotationsTab(varargin)
            if nargin == 0
                obj.FirstAxis = 'none';
                obj.Rotation1 = 0;
                obj.SecondAxis = 'none';
                obj.Rotation2 = 0;
                obj.ThirdAxis = 'none';
                obj.Rotation3 = 0;
            end
        end
        
        function set.FirstAxis(obj, firstAxis)
            options = {'none', 'x', 'y', 'z'};
            obj.FirstAxis = set_value_from_list(options, firstAxis);
        end
        
        function rotation1 = get.Rotation1(obj)
            if strcmp(obj.FirstAxis, 'none') == 0
                rotation1 = obj.Rotation1_UserDefined;
            else
                rotation1 = obj.Rotation1;
            end
        end

            
        function set.SecondAxis(obj, secondAxis)
            options = {'none', 'x', 'y', 'z'};
            obj.SecondAxis = set_value_from_list(options, secondAxis);
        end
        
        function rotation2 = get.Rotation2(obj)
            if strcmp(obj.SecondAxis, 'none') == 0
                rotation2 = obj.Rotation2_UserDefined;
            else
                rotation2 = obj.Rotation2;
            end
        end
            
        function set.ThirdAxis(obj, thirdAxis)
            options = {'none', 'x', 'y', 'z'};
            obj.ThirdAxis = set_value_from_list(options, thirdAxis);
        end
        
        function rotation3 = get.Rotation3(obj)
            if strcmp(obj.ThirdAxis, 'none') == 0
                rotation3 = obj.Rotation3_UserDefined;
            else
                rotation3 = obj.Rotation3;
            end
        end
    end
    
    methods(Static)
        test();
    end
end