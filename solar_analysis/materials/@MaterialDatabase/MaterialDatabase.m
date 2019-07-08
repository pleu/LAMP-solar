classdef MaterialDatabase < handle
%MATERIALDATABASE 
%   
  
  properties
    Instances;
  end
  
  methods 
    function [md] = MaterialDatabase(materials)
      if iscell(materials)
        for i = 1:length(materials)
          md.Instances = containers.Map({materials{i}},...
          {MaterialType.create(materials{i})});
        end
      else
        md.Instances = containers.Map({materials},...
          {MaterialType.create(materials)});
      end
    end
  end  
  
  methods(Static)
    function [obj] = getNamed(md, material)
      if isKey(md.Instances, material)
        obj = md.Instances(material);
      else
        obj = MaterialType.create(material);
        md.Instances(material) = obj;
      end
    end
    
    test()
  end
end

