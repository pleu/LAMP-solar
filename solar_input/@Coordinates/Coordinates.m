classdef Coordinates < handle
% COORDINATES class for solar spectrum
% 
% obj = Coordinates('Center', 0, 'Span', 4);
% obj = Coordinates('Min', -3, 'Max', 3);
%
% See also 
%
% Copyright 2011
% Paul Leu
  
  properties
    Center@double; % in meters
    Span@double;   % in meters
  end
  
  properties(Dependent = true)
    Min@double;    % in meters
    Max@double;    % in meters
  end
  
  methods 
    
    function obj = Coordinates(center, span)
      % Constructor
      if nargin == 0
      else
        obj.Center = center;
        obj.Span = span;
      end
    end  
    
    function min = get.Min(obj)
      min = obj.Center - obj.Span/2;
    end
    
    function max = get.Max(obj)
      max = obj.Center + obj.Span/2;
    end

    function set.Min(obj, min)
      if min > obj.Max
        obj.Center = min;
        obj.Span = 0;
      else
        max = obj.Max;
        obj.Center = (min+max)/2;
        obj.Span = max-min;
      end
    end
    
    function set.Max(obj, max)
      if max < obj.Min
        obj.Center = max;
        obj.Span = 0;
      else
        min = obj.Min;
        obj.Center = (min+max)/2;
        obj.Span = max-min;
      end
    end
    
  end

  methods(Static)
    test();
  end
  
end

