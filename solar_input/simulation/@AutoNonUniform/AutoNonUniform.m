classdef AutoNonUniform < handle
    properties 
        MeshAccuracy;
        MinMeshStep;
        MeshRefinement;
        MeshingRefinement;
        DtStabilityFactor;
        meshingrefinement = 1;    
    end
    
%     methods(Access = protected)
%         
%     end
    
    methods
        function obj = AutoNonUniform(meshaccuracy, minmeshStep)
            if nargin == 0
                obj.MeshAccuracy = 2;
                obj.MeshRefinement = 'staircase';
                obj.DtStabilityFactor = 0.99;
                obj.MinMeshStep = 0.02e-6;
            else
                obj.MeshAccuracy = meshaccuracy;
                obj.MeshRefinement = 'staircase';
                obj.DtStabilityFactor = 0.99;
                obj.MinMeshStep = minmeshStep;                
                
            end
        end
    
%         function meshAccuracy = get.MeshAccuracy(obj)
%         meshAccuracy = obj.meshaccuracy;
%         end
        
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
        
%         function MeshAccuracy = get.MeshAccuracy(obj)
%           MeshAccuracy = obj.MeshAccuracy;
%         end
%         
%         function MinMeshStep = get.MinMeshStep(obj)
%           MinMeshStep = obj.MinMeshStep;
%         end
%         
%         function set.MeshAccuracy(obj, MeshAccuracy)
%           obj.MeshAccuracy = MeshAccuracy;
%         end
%         
%         function set.MinMeshStep(obj, MinMeshStep)
%           obj.MinMeshStep = MinMeshStep;
%         end
    end
    
    methods(Static)
        test();
    end
    
end