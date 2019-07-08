classdef TwoDArray < handle
  %TWODDIFFRACTIONSTRUCTURE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Pitch@double;
    Lattice@double;     % in nm
    Number@double;
  end
  
  properties(Dependent)
    ReciprocalLattice;
  end

  
  methods
    function [reciprocalLattice] = get.ReciprocalLattice(obj)
      reciprocalLattice = (2*pi*(inv(obj.Pitch*obj.Lattice')));
    end

    function set.Pitch(obj, value)
      if (value < 0)
        error('Pitch value must be positive');
      elseif ~isscalar(value)
        error('Pitch must be scalar');
      else
        obj.Pitch = value;
      end
    end

    
%     function [pitch] = get.Pitch(obj)
%       pitch = zeros(2, 1);
%       for i = 1:size(obj.Lattice, 1)
%         pitch(i) = norm(obj.Lattice(i, :));
%       end
%     end

    
    function set.Lattice(obj, value)
      if size(value, 1)~=2 && size(value, 2)~=2
        error('GratingLattice must be 2x2 array');
      else
        obj.Lattice = value;
      end
    end
    
    function set.Number(obj, value)
      if length(value) ~= 2
        error('Number must be a vector of length 2');
      else
        if prod(mod(value,0) | isinf(value))      % isinteger(value)
          obj.Number = value;
        else
          error('Number must be an integer or inf');
        end
      end
    end

  end
  
  methods(Static)
    test()
  end
  
end

