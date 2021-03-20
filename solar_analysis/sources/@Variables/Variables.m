classdef Variables < handle
  %UNTITLED13 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Name;
    Label;
    Units;
  end
  
  methods
    function obj = Variables(name, label, units)
      %UNTITLED13 Construct an instance of this class
      %   Detailed explanation goes here
      %obj = Variables.empty(length(name), 0);
      %for i  = length(name)
      obj.Name = name;
      obj.Label = label;
      obj.Units = units;
      %end
    end
    
    function obj = add(obj, name, label, units)
      %       objNew = Variables.empty(length(obj)+1, 0);
      %       for i = 1:length(obj)
      %         objNew(i) = obj(i);
      %       end
      obj(length(obj)+1) = Variables(name, label, units);
    end
  end
  
  methods(Static)
    test()
    
    obj = create_array(name, index, label, units)
  end
end

