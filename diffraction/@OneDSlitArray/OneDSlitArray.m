classdef OneDSlitArray < handle & OneDArray
  %UNTITLED2 Summary of this class goes here
  %   Detailed explanation goes here
  
 
  properties(Dependent)
    HoleWidth; % in nm
    Width;
    Transparency;
  end
  
  properties(Hidden)
    Dimensions = 1;
  end

  
  properties(Access = 'private')
    OneDSlit; 
  end
  
  methods
    function obj = OneDSlitArray(pitch, number, holeWidth)
      if nargin ~= 0
        obj(length(pitch)*length(number)*length(holeWidth)) = OneDSlitArray;
        for i = 1:length(pitch)
          for j = 1:length(number)
            for k = 1:length(holeWidth)
              %obj(i, j, k).HoleWidth = holeWidth(i);
              obj(i, j, k).Pitch = pitch(i);
              obj(i, j, k).Number = number(j);
              %obj.HoleWidth = holeWidth;
              obj(i, j, k).OneDSlit= OneDSlit(holeWidth(k));
            end
          end
        end
      end
      

    end
    
    function [transparency] = get.Transparency(obj)
      transparency = obj.HoleWidth/obj.Pitch;
    end
    
    function [holeWidth] = get.HoleWidth(obj)
      holeWidth = obj.OneDSlit.HoleWidth;
    end

    function set.HoleWidth(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.OneDSlit.HoleWidth = value;
      end
    end
    
    
    function width = get.Width(obj)
      width = obj.Pitch - obj.HoleWidth;
    end
    
    function set.Width(obj, value)
      if (value < 0)
        error('Property value must be positive');
      else
        obj.HoleWidth = obj.Pitch - value;
      end
    end
    
    
  end
  
  methods(Static)
    test()
    
    test2()
    
    function [obj] = create_array(pitch, number, diameter)
      valueCombinations = allcomb(pitch, diameter);
      obj(length(pitch)*length(diameter)) = OndDSlitArrayArray();
      for i = 1:size(valueCombinations, 1)
        obj(i) = OneDSlitArray(valueCombinations(i, 1), number, valueCombinations(i, 2));
      end
    end
    
        
  end
    
end

