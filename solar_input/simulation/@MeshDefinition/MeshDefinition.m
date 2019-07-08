classdef MeshDefinition < handle
    properties
        MeshDefinitionType;
        MaximumMeshStepSettings;
        MeshCells;
        MeshGrading;
    end
    
    methods(Access = protected)
        function flag = isInactivePropertyImpl(obj,propertyName)
            if strcmp('MeshDefinitionType', propertyName)
                flag = false;
            else
                if strcmp(obj.MeshDefinitionType, 'mesh cells per wavelength')
                    if getnameidx('MeshGrading', propertyName)
                        flag = false;
                    else
                        flag = true;
                    end
                elseif strcmp(obj.MeshDefinitionType, 'maximum mesh step')
                    if getnameidx({'MeshGrading', 'MaximumMeshStepSettings'}, propertyName)
                        flag = false;
                    else
                        flag = true;
                    end
                elseif strcmp(obj.MeshDefinitionType, 'max mesh stop and mesh cells per wavelength')
                    if getnameidx({'MeshGrading', 'MaximumMeshStepSettings'}, propertyName)
                        flag = false;
                    else 
                        flag = true;
                    end
                elseif strcmp(obj.MeshDefinitionType, 'number of mesh cells')
                    if getnameidx('MeshCells', propertyName)
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
        function obj = MeshDefinition(meshdefinitionType, maximummeshstep, meshcells)
            if nargin == 0
                obj.MeshDefinitionType = 'maximum mesh step';
                obj.MeshGrading = 1;
                obj.MaximumMeshStepSettings = 0.02e-6;
                obj.MeshCells = 200;
            else
                obj.MeshDefinitionType = meshdefinitionType;
                obj.MeshGrading = 1;
                obj.MaximumMeshStepSettings = maximummeshstep;
                obj.MeshCells = meshcells;
            end
        end
        
        function set.MeshDefinitionType(obj, meshDefinitionType)
            options = {'mesh cells per wavelength', 'maximum mesh step',...
                'max mesh stop and mesh cells per wavelength', 'number of mesh cells'};
            obj.MeshDefinitionType = set_value_from_list(options, meshDefinitionType);
        end
        
        function set.MeshGrading(obj, meshGrading)
            obj.MeshGrading = set_check_box(meshGrading);
        end
                
                
    end

    methods(Static)
        test();
    end    
end