classdef AbsorberType < handle
% ABSORBERTYPE class for material properties
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  properties
    Type;
    AbsorptionResults; % this is monitor object
  end
    
  methods(Access = protected)
    function at = AbsorberType(absorber)
      if nargin ~= 0
        at.Type = absorber;
      end
    end   
  end
  
  methods(Static)    
    test()
    
    % change this to getNamed
    % 
    function obj = create(absorber) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', absorber, ';']);
      catch me
        error([absorber, 'is currently not supported']);
      end      
    end
    
    
  end
  
end

