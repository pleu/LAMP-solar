classdef GeneralTab
%GENERAL Summary of this class goes here
%   Detailed explanation goes here
  properties
    Type;
  end
    
  methods(Access = protected)
    function mt = GeneralTab(type)
      if nargin ~= 0
        mt.Type = type;
      end
    end   
  end
  
  methods(Static)
    test();
    
    function obj = create(type) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', type, ';']);
      catch me
        error([type, ' is currently not supported']);
      end      
    end
  end
  
end