classdef ScalarField
  %SCALARFIELD Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Value;
  end
  
  methods
    function obj = ScalarField(value)
      obj.Value = value;
    end
  end
  
  methods(Static) 
    function obj = create(filename)
      value = ScalarField.read_from_file([filename, '.mat']);
      obj = ScalarField(value);
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

  end
  
  
  
end

