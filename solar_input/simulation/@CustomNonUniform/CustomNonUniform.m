classdef CustomNonUniform < handle
    properties
        DefineXMesh;
        DefineYMesh;
        DefineZMesh;
        AllowGradingInX;
        AllowGradingInY;
        AllowGradingInZ;
        GradingFactor;
        MeshRefinement;
        MeshingRefinement;
        meshingrefinement = 1;
        Dx;
        Dy;
        Dz;
        MeshCellsPerWavelength;
        MeshCellsX;
        MeshCellsY;
        MeshCellsZ;
        DtStabilityFactor;
        MinMeshStep;        
    end
    
%     properties(Dependent)
%     end
    
    properties(Access = 'private')
        MeshDefinitionX;
        MeshDefinitionY;
        MeshDefinitionZ;
    end
    
    methods
        function obj = CustomNonUniform(varargin)
            if nargin == 0
                obj.GradingFactor = 1.41421;
                obj.MeshRefinement = 'conformal variant 1';
                obj.DtStabilityFactor = 0.99;
                obj.MinMeshStep = 0.02e-6;
                obj.MeshCellsPerWavelength = 10;
                obj.MeshDefinitionX = MeshDefinition();
                obj.MeshDefinitionY = MeshDefinition();
                obj.MeshDefinitionZ = MeshDefinition();
            end
        end
            
        function set.MeshRefinement(obj, meshRefinement)
            options = {'staircase', 'conformal variant 0', 'conformal variant 1', 'conformal variant 2',...
                'dielectric volume average', 'volume average', 'Yu-Mittra method 1',...
                'Yu-Mittra method 2'};
            obj.MeshRefinement = set_value_from_list(options, meshRefinement);
        end
        
        function meshingRefinement = get.MeshingRefinement(obj)
%            if strcmp(obj.MeshRefinement, 'dielectric volume average')
                meshingRefinement = obj.meshingrefinement;
%            end
        end
        
        function defineXMesh = get.DefineXMesh(obj)
            defineXMesh = obj.MeshDefinitionX.MeshDefinitionType;
        end
        
        function defineYMesh = get.DefineYMesh(obj)
            defineYMesh = obj.MeshDefinitionY.MeshDefinitionType;
        end
        
        function defineZMesh = get.DefineZMesh(obj)
            defineZMesh = obj.MeshDefinitionZ.MeshDefinitionType;
        end 
        
        function allowGradingInX = get.AllowGradingInX(obj)
            allowGradingInX = obj.MeshDefinitionX.MeshGrading;
        end
        
        function allowGradingInY = get.AllowGradingInY(obj)
            allowGradingInY = obj.MeshDefinitionY.MeshGrading;
        end
        
        function allowGradingInZ = get.AllowGradingInZ(obj)
            allowGradingInZ = obj.MeshDefinitionZ.MeshGrading;
        end
        
        function dx = get.Dx(obj)
            dx = obj.MeshDefinitionX.MaximumMeshStepSettings;
        end
        
        function dy = get.Dy(obj)
            dy = obj.MeshDefinitionY.MaximumMeshStepSettings;
        end
        
        function dz = get.Dz(obj)
            dz = obj.MeshDefinitionZ.MaximumMeshStepSettings;
        end  
        
        function meshCellsX = get.MeshCellsX(obj)
            meshCellsX = obj.MeshDefinitionX.MeshCells;
        end
        
        function meshCellsY = get.MeshCellsY(obj)
            meshCellsY = obj.MeshDefinitionY.MeshCells;
        end
        
        function meshCellsZ = get.MeshCellsZ(obj)
            meshCellsZ = obj.MeshDefinitionZ.MeshCells;
        end  
    end
    
    methods(Static)
        test();
    end
    
end