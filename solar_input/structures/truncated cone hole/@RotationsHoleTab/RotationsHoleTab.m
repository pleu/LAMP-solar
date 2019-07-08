classdef RotationsHoleTab < handle
    properties(Dependent)
        FirstAxis
        Rotation1
        SecondAxis
        Rotation2
        ThirdAxis
        Rotation3
    end
    
    properties(Access = 'private')
        FirstRotation;
        SecondRotation;
        ThirdRotation;
    end
    
    methods
        function obj = RotationsHoleTab()
                obj.FirstRotation = Rotations();
                obj.SecondRotation = Rotations();
                obj.ThirdRotation = Rotations();
        end
        
        function firstAxis = get.FirstAxis(obj)
            firstAxis = obj.FirstRotation.Axis;
        end
        
        function rotation1 = get.Rotation1(obj)
            rotation1 = obj.FirstRotation.Rotation;
        end
        
        function secondAxis = get.SecondAxis(obj)
            secondAxis = obj.SecondRotation.Axis;
        end     
        
        function rotation2 = get.Rotation2(obj)
            rotation2 = obj.SecondRotation.Rotation;
        end        
        
        function thirdAxis = get.ThirdAxis(obj)
            thirdAxis = obj.ThirdRotation.Axis;
        end        
        
        function rotation3 = get.Rotation3(obj)
            rotation3 = obj.ThirdRotation.Rotation;
        end     
        
        function set.FirstAxis(obj, firstAxis)
            obj.FirstRotation.Axis = firstAxis;
        end        
        
        function set.Rotation1(obj, rotation1)
            obj.FirstRotation.Rotation = rotation1;
        end
        
        function set.SecondAxis(obj, secondAxis)
            obj.SecondRotation.Axis = secondAxis;
        end        
        
        function set.Rotation2(obj, rotation2)
            obj.SecondRotation.Rotation = rotation2;
        end
        
        function set.ThirdAxis(obj, thirdAxis)
            obj.ThirdRotation.Axis = thirdAxis;
        end        
        
        function set.Rotation3(obj, rotation3)
            obj.ThirdRotation.Rotation = rotation3;
        end     
    end
    
    methods(Static)
        test();
    end
end
% classdef RotationsTab < handle
%     properties
%         Rotation1_UserDefined = 10;
%         Rotation2_UserDefined = 10;
%         Rotation3_UserDefined = 10;
%         FirstAxis
%         Rotation1
%         SecondAxis
%         Rotation2
%         ThirdAxis
%         Rotation3
%     end
%     
%     methods
%         function obj = RotationsTab(varargin)
%             if nargin == 0
%                 obj.FirstAxis = 'none';
%                 obj.Rotation1 = 0;
%                 obj.SecondAxis = 'none';
%                 obj.Rotation2 = 0;
%                 obj.ThirdAxis = 'none';
%                 obj.Rotation3 = 0;
%             end
%         end
%         
%         function set.FirstAxis(obj, firstAxis)
%             options = {'none', 'x', 'y', 'z'};
%             obj.FirstAxis = set_value_from_list(options, firstAxis);
%         end
%         
%         function rotation1 = get.Rotation1(obj)
%             if strcmp(obj.FirstAxis, 'none') == 0
%                 rotation1 = obj.Rotation1_UserDefined;
%             else
%                 rotation1 = obj.Rotaion1;
%             end
%         end
%             
%         function set.SecondAxis(obj, secondAxis)
%             options = {'none', 'x', 'y', 'z'};
%             obj.SecondAxis = set_value_from_list(options, secondAxis);
%         end
%         
%         function rotation2 = get.Rotation2(obj)
%             if strcmp(obj.SecondAxis, 'none') == 0
%                 rotation2 = obj.Rotation2_UserDefined;
%             else
%                 rotation2 = obj.Rotaion2;
%             end
%         end
%             
%         function set.ThirdAxis(obj, thirdAxis)
%             options = {'none', 'x', 'y', 'z'};
%             obj.ThirdAxis = set_value_from_list(options, thirdAxis);
%         end
%         
%         function rotation3 = get.Rotation3(obj)
%             if strcmp(obj.ThirdAxis, 'none') == 0
%                 rotation3 = obj.Rotation3_UserDefined;
%             else
%                 rotation3 = obj.Rotaion3;
%             end
%         end
%     end
%     
%     methods(Static)
%         test();
%     end
% end