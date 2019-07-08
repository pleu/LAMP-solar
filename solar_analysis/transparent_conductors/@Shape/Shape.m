classdef Shape < handle
%SHAPE interface
%
%
  properties(Abstract)
    Area;
  end
  
%   methods(Access = protected)
%     function obj = ShapeType(shape)
%       if nargin ~= 0
%         obj.Type = shape;
%       end
%     end   
%   end
  
  methods(Static)    
    test()
%     
%     function obj = create(shape) %#ok<STOUT>
%       % factory method for creating materials
%       try
%         eval(['obj = ', shape, ';']);
%       catch me
%         error([shape, 'is currently not supported']);
%       end
%     end
    
    
  end
  
end

