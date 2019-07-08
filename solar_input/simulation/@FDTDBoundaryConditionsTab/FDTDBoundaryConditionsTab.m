classdef FDTDBoundaryConditionsTab < handle
    properties
        AllowSymmetryOnAllBoundaries;
        KX;
        KY;
        KZ;
        kx = 0;
        ky = 0;
        kz = 1.2342e7;
        PMLReflection;
        pmlreflection = 0.0001
    end
    
    properties(Dependent)
        XMinBc;
        XMaxBc;
        YMinBc;
        YMaxBc;
        ZMinBc;
        ZMaxBc;
        SetBasedOnSourceAngle;   
        BlochUnits;        
    end
    
    properties(Access = 'private')
        XBoundaryCondition;
        YBoundaryCondition;
        ZBoundaryCondition;
    end
%     properties(Dependent)
%         PmlLayers;
%     end
    
    methods(Access = protected)
    end
    
    methods
        function obj = FDTDBoundaryConditionsTab(varargin)
            if nargin == 0
                obj.XBoundaryCondition = BoundaryCondition();
                obj.YBoundaryCondition = BoundaryCondition();
                obj.ZBoundaryCondition = BoundaryCondition();                
                obj.ZMinBc = 'PML';
                obj.ZMaxBc = 'PML';
                obj.AllowSymmetryOnAllBoundaries = 1;
                obj.SetBasedOnSourceAngle = 0;
                obj.BlochUnits = 'SI';
                obj.PMLReflection = 0.0001;
            end
        end
        
        function set.AllowSymmetryOnAllBoundaries(obj, allowSymmetryOnAllBoundaries)
          obj.AllowSymmetryOnAllBoundaries = set_check_box(allowSymmetryOnAllBoundaries);
        end
        
        function xMinBc = get.XMinBc(obj)
            xMinBc = obj.XBoundaryCondition.MinBc;
        end
        
        function xMaxBc = get.XMaxBc(obj)
            xMaxBc = obj.XBoundaryCondition.MaxBc;
        end
        
        function yMinBc = get.YMinBc(obj)
            yMinBc = obj.YBoundaryCondition.MinBc;
        end
        
        function yMaxBc = get.YMaxBc(obj)
            yMaxBc = obj.YBoundaryCondition.MaxBc;
        end
        
        function zMinBc = get.ZMinBc(obj)
            zMinBc = obj.ZBoundaryCondition.MinBc;
        end
        
        function zMaxBc = get.ZMaxBc(obj)
            zMaxBc = obj.ZBoundaryCondition.MaxBc;
        end 
        
        function set.XMinBc(obj, xMinBc)
            obj.XBoundaryCondition.MinBc = xMinBc;
        end
        
        function set.XMaxBc(obj, xMaxBc)
            obj.XBoundaryCondition.MaxBc = xMaxBc;
        end
            
        function set.YMinBc(obj, yMinBc)
            obj.YBoundaryCondition.MinBc = yMinBc;
        end
        
        function set.YMaxBc(obj, yMaxBc)
            obj.YBoundaryCondition.MaxBc = yMaxBc;
        end
        
        function set.ZMinBc(obj, zMinBc)
            obj.ZBoundaryCondition.MinBc = zMinBc;
        end
        
        function set.ZMaxBc(obj, zMaxBc)
            obj.ZBoundaryCondition.MaxBc = zMaxBc;
        end
        
        function set.SetBasedOnSourceAngle(obj, setBasedOnSourceAngle)
            if strcmp({obj.XMinBc, obj.YMinBc, obj.ZMinBc}, 'Bloch')
                obj.SetBasedOnSourceAngle = set_check_box(setBasedOnSourceAngle);
            end
        end     
        
        function set.BlochUnits(obj, blochUnits)
            if strcmp({obj.XMinBc, obj.YMinBc, obj.ZMinBc},...
                    'Bloch') & obj.SetBasedOnSourceAngle == 0
                options = {'SI', 'bandstructure'};
                obj.BlochUnits = set_value_from_list(options, blochUnits);
            end
        end   
        
        function kX = get.KX(obj)
            if strcmp({XMinBc, XMaxBc}, 'Bloch') && obj.SetBasedOnSourceAngle == 0
                kX = obj.kx;
            end
        end
        
        function kY = get.KY(obj)
            if strcmp({YMinBc, YMaxBc}, 'Bloch') && obj.SetBasedOnSourceAngle == 0
                kY = obj.ky;
            end
        end
        
        function kZ = get.KZ(obj)
            if strcmp({ZMinBc, ZMaxBc}, 'Bloch') && obj.SetBasedOnSourceAngle == 0
                kZ = obj.kz;
            end
        end
        
        function pmlReflection = get.PMLReflection(obj)
            pmlReflection = obj.pmlreflection;
        end
    end
    
    methods(Static)
        test();
    end
end