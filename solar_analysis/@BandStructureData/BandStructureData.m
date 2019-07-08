classdef BandStructureData
% MONITOR class for simulation monitor results
% 
% See also 
%
% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh
  properties
    Type;       % must be TE or TM 
    Frequency;  % normalized frequency (in units of a/c) 
    WaveVector; % 
    K_Parallel; % the value of k in the parallel direction
  end
  
  methods
    function obj = BandStructureData(type, frequency, wavevector, k_parallel)
      if nargin > 0
        obj.Type = type;
        obj.Frequency = frequency;
        obj.WaveVector = wavevector;
        obj.K_Parallel=k_parallel;
      end
    end
    
    function obj = set.Type(obj,type)
      if ~(strcmpi(type,'TE') || ...
          strcmpi(type,'TM'))
        error('Type must be  TE or TM');
      end
      obj.Type = type;
    end
    
    
  end
  
end