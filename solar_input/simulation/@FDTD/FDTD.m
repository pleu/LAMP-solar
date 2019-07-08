classdef FDTD
%FDTD Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    Geometry;
    MeshSettings;
    BoundaryConditions;
    AdvancedOptions;
  end

  methods
    function obj = FDTD()
      if nargin == 0
        % Default values
        obj.General = FDTDGeneralTab();
        obj.Geometry = GeometryFDTDTab();
        obj.MeshSettings = FDTDMeshSettingsTab('uniform');
        obj.BoundaryConditions = FDTDBoundaryConditionsTab();
        obj.AdvancedOptions = FDTDAdvancedOptionsTab();
      end
    end
    
  end
  
  methods(Static) 
    test();
  end
  
end
