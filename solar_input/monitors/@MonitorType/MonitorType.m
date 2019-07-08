classdef MonitorType
%MONITOR Summary of this class goes here
%   Detailed explanation goes here
  properties
    Type;
  end
    
  methods(Access = protected)
    function mt = Monitor(monitor)
      if nargin ~= 0
        mt.Type = monitor;
      end
    end   
  end
  
  methods(Static)
    test();
    
    function obj = create(monitor) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', monitor, ';']);
      catch me
        error([monitor, ' is currently not supported']);
      end      
    end
  end
  
end
