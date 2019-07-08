classdef CircularHoleArray < TwoDArray
  %CIRCULARHOLEARRAY Summary of this class goes here
  %   Detailed explanation goes here
    
  properties(Dependent)
    Diameter; % in nm
    Transparency;
  end
  
  properties(Access = 'private')
    CircularHole; 
  end
  
  properties(Hidden)
    Dimensions = 2;
  end
  
  methods
    function obj = CircularHoleArray(pitch, lattice, number, diameter)
      if nargin ~=0
        obj.Pitch = pitch;
        obj.Lattice = lattice;
        obj.Number = number;
        obj.CircularHole = CircularHole(diameter);
      end
    end
    

    
    function [diameter] = get.Diameter(obj)
      diameter = obj.CircularHole.Diameter;
    end
    
    function [transparency] = get.Transparency(obj)
      area = obj.Pitch^2*norm(cross([obj.Lattice(1, :) 0], [obj.Lattice(2, :) 0]));
      transparency = pi*obj.Diameter^2/4/area;
    end
    
    function set.Diameter(obj, value)
      if (value < 0)
        error('Property value must be positive');
      elseif isscalar(value)
        error('Diameter must be scalar');
      else
        obj.CircularHole.Diameter = value;
      end
    end

    
  end

  methods(Static)
    test()
    test2()

    function [obj] = create_from_variable_array(va, lattice, number)
      %valueCombinations = allcomb(pitch, diameter);
      obj(va.NumValues) = CircularHoleArray();
      for i = 1:va.NumValues
        obj(i) = CircularHoleArray(va.Values(i, 1), lattice, number, va.Values(i, 2));
      end
    end

    
    function [obj] = create_array(pitch, lattice, number, diameter)
      valueCombinations = allcomb(pitch, diameter);
      obj(length(pitch)*length(diameter)) = CircularHoleArray();
      for i = 1:size(valueCombinations, 1)
        obj(i) = CircularHoleArray(valueCombinations(i, 1), lattice, number, valueCombinations(i, 2));
      end
    end
    
    
    
  end
    
  
end

