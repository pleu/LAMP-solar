classdef VectorField
  %VECTORFIELD Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    VecX; 
    VecY;
    VecZ;
    Vec2; % vector squared
  end
  
  methods
    function obj = VectorField(vecX, vecY, vecZ, vec2)
      VectorField.error_check(vecX, vecY, vecZ, vec2);
      obj.VecX = vecX;
      obj.VecY = vecY;
      obj.VecZ = vecZ;
      obj.Vec2 = vec2;
    end
        
  end
  
  methods(Static) 
    function obj = create(filename)
      vecX = VectorField.read_from_file([filename, 'x.mat']); 
      vecY = VectorField.read_from_file([filename, 'y.mat']); 
      vecZ = VectorField.read_from_file([filename, 'z.mat']); 
      vec2 = VectorField.read_from_file([filename, '2.mat']);
      obj = VectorField(vecX, vecY, vecZ, vec2);
    end
    
    function out = read_from_file(file)
      if exist(file, 'file')
        %out = load(file);
        foo = load(file);
        baz = fieldnames(foo);
        out = foo.(baz{1});
      else
        out = 0;
      end
    end
    
    function error_check(vecX, vecY, vecZ, vec2)
      if ~all(size(vecX)==size(vecY))
        if ~isscalar(vecX) && ~isscalar(vecY)
          error('Check field sizes');
        end
      end
      if ~all(size(vecX)==size(vecZ))
        if ~isscalar(vecX) && ~isscalar(vecZ)
          error('Check field sizes');
        end
      end
      if ~all(size(vecX)==size(vec2))
        if ~isscalar(vecX) && ~isscalar(vec2)
          error('Check field sizes');
        end
      end
      
    end

  end
  
end

