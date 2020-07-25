classdef IntegratedDataArray
  %UNTITLED Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    VariableArray;
    IntegratedData;
  end
  
  methods
    function obj = IntegratedDataArray(variableArray, integratedData)
      if nargin~=0
        obj.VariableArray = variableArray;
        obj.integratedData = integratedData;
      end
    end    
    
  end
    function outputArg = method1(obj,inputArg)
      %METHOD1 Summary of this method goes here
      %   Detailed explanation goes here
      outputArg = obj.Property1 + inputArg;
    end
  end
end

