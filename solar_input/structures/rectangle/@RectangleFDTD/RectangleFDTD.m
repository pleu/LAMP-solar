classdef RectangleFDTD < handle
%PLANESOURCE Summary of this class goes here
%Detailed explanation goes here
  properties
    Geometry;
    Material;
    Rotations;
    GraphicalRendering;
  end

  properties(Dependent)
    OpticalMaterial = obj.Material.OpticalMaterial;
%     ZSpan;
%     XSpan;
%     YSpan;
  end

  
  methods
    function obj = RectangleFDTD(zSpan, xSpan)
      if nargin == 0
        % Default values
        obj.Geometry = ReGeometryTab();
        obj.Material = MaterialTab();
        obj.Rotations = RotationsTab();
        obj.GraphicalRendering = GraphicalRenderingTab();
      elseif nargin == 2
        obj.Geometry = ReGeometryTab();
        obj.Material = MaterialTab();
        obj.Rotations = RotationsTab();
        obj.GraphicalRendering = GraphicalRenderingTab();        
        obj.Geometry.XSpan = xSpan;
        obj.Geometry.YSpan = xSpan;
        obj.Geometry.ZSpan = zSpan;
      end
    end
    
    function [opticalMaterial] = get.OpticalMaterial(obj)
      opticalMaterial = obj.Material.MaterialValue;
    end
    
%     function ZSpan = get.ZSpan(obj)
%       ZSpan = obj.Geometry.ZSpan;
%     end
%  
%     function XSpan = get.XSpan(obj)
%       XSpan = obj.Geometry.XSpan;
%     end
% 
%     function YSpan = get.YSpan(obj)
%       YSpan = obj.Geometry.YSpan;
%     end
    
    function set.OpticalMaterial(obj, material)
      obj.Material.OpticalMaterial = material;
    end
    
%     function set.ZSpan(obj, zSpan)
%         obj.ZSpan = zSpan;      
%     end
%      
%     function set.XSpan(obj, xSpan)
%         obj.XSpan = xSpan;      
%     end
%  
%     function set.YSpan(obj, xSpan)
%         obj.YSpan = xSpan;      
%     end
    
  end
  
  methods(Static) 
    test();
  end
  
end