classdef Source
%SOURCE Summary of this class goes here
%   Detailed explanation goes here
  properties
    Type;
  end
    
  methods(Access = protected)
    function mt = Source(source)
      if nargin ~= 0
        mt.Type = source;
      end
    end   
  end
  
  methods(Static)
    test();
    
    function obj = create(source) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', source, ';']);
      catch me
        error([source, ' is currently not supported']);
      end      
    end
  end
  
end

