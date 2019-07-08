classdef TwoDSlitArray < handle & TwoDArray
  %UNTITLED2 Summary of this class goes here
  %   Detailed explanation goes here
  
  
  properties(Dependent)
    HoleWidth; % in nm
    Width;
  end
  
  properties(Access = 'private')
    TwoDSlit; 
  end
  
  properties(Hidden)
    Dimensions = 2;
  end
  
  methods
    function obj = TwoDSlitArray(pitch, lattice, number, holeWidth)
      obj.Lattice = lattice;
      obj.Pitch = pitch;
      obj.Number = number; 
      obj.TwoDSlit = TwoDSlit(holeWidth);
    end
    
    function [holeWidth] = get.HoleWidth(obj)
      holeWidth = obj.TwoDSlit.HoleWidth;
    end

    function set.HoleWidth(obj, value)
      if length(value) ~= 2
        error('Hole width must be a vector of length 2');
      else
%         if size(value, 2) == 2
%           value = value';
%         end
        if (sum(value < 0) ~= 0)
          error('Property value must be positive');
        else
          obj.TwoDSlit.HoleWidth = value; 
        end
      end
    end
    
    
    function width = get.Width(obj)
      width = obj.Pitch - obj.HoleWidth;
    end
    
    function set.Width(obj, value)
      if length(value) ~= 2
        error('Width must be a vector of length 2');
      else
        if (sum(value < 0) ~= 0)
          error('Width value must be positive');
        else
          obj.HoleWidth = obj.Pitch - value;
        end
      end
    end
    
    
  end
  
  methods(Static)
    test()
        
  end
    
end

