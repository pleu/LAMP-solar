classdef GraphicalRenderingTab < handle
    
    properties
        Alpha_UserDefined = 0.9;
        RenderType;
        Detail;
        OverrideColorOpacityFromMaterialDatabase;
        Alpha;
    end
    
    methods
        function obj = GraphicalRenderingTab(varargin)
            if nargin == 0
                obj.RenderType = 'detailed';
                obj.Detail = 0.5;
                obj.OverrideColorOpacityFromMaterialDatabase = 1;
                obj.Alpha = 1;
            end
        end
        
        function set.RenderType(obj, renderType)
            options = {'detailed', 'wireframe'};
            obj.RenderType = set_value_from_list(options,renderType);
        end
        
        function set.OverrideColorOpacityFromMaterialDatabase(obj,...
                overrideColorOpacityFromMaterialDatabase)
            obj.OverrideColorOpacityFromMaterialDatabase = set_check_box(...
                overrideColorOpacityFromMaterialDatabase);
        end
        
        function alpha = get.Alpha(obj)
            if obj.OverrideColorOpacityFromMaterialDatabase == 1
                alpha = obj.Alpha_UserDefined;
            else
                alpha = obj.Alpha;
            end
        end      
    end
    
    methods(Static)
        test();
    end
end