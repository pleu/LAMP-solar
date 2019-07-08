classdef FDTDMeshSettingsTab < handle
    properties
        MeshType;
        MeshSettings;
    end
    
    methods
        function obj = FDTDMeshSettingsTab(type)
            if nargin == 0
                obj.MeshType = 'auto non-uniform';
            else
                obj.MeshType = type;
            end
        end
        
        function set.MeshType(obj, meshType)
            options = {'auto non-uniform', 'custom non-uniform', 'uniform'};
            obj.MeshType = set_value_from_list(options, meshType);
        end
        
         function meshSettings = get.MeshSettings(obj)
             if strcmp(obj.MeshType, 'auto non-uniform')
                 meshSettings = AutoNonUniform();
             elseif strcmp(obj.MeshType, 'custom non-uniform')
                 meshSettings = CustomNonUniform();
             elseif strcmp(obj.MeshType, 'uniform')
                 meshSettings = Uniform();
             end
        end
        
    end
    
    methods(Static)
        test();
    end
end