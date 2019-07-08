classdef RefractiveIndex
%FrequencyDomainFieldPower Summary of this class goes here
%Detailed explanation goes here
  properties
    General;
    Geometry;
    Advanced;
  end
  
  methods
    function obj = RefractiveIndex()
      if nargin == 0
        % Default values
         obj.Geometry = GeometryTab();
         obj.Advanced = AdvancedTab();
      end
    end
  end
  
  methods(Static) 
    test();
  end
  
end
