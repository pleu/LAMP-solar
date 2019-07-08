classdef Mesh
%FDTD Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    Geometry;
  end

  methods
    function obj = FDTD()
      if nargin == 0
        % Default values
        obj.General = FDTDGeneralTab();
        obj.Geometry = GeometryTab();
      end
    end
    
  end
  
  methods(Static) 
    test();
  end
  
end
