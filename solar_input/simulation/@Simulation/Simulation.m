classdef Simulation
%Simulation Summary of this class goes here
%   Detailed explanation goes here
  properties
    Type;
  end
    
  methods(Access = protected)
    function mt = Simulation(simulation)
      if nargin ~= 0
        mt.Type = simulation;
      end
    end   
  end
  
  methods(Static)
    test();
    
    function obj = create(simulation) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', simulation, ';']);
      catch me
        error([simulation, ' is currently not supported']);
      end      
    end
  end
  
end
