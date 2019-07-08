classdef Absorber 
%ABSORBPTIONSTRUCTURETYPE interface
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  

  properties(Abstract)
    AbsorptionResults; % this is monitor object
    TransmissionResults;
    ReflectionResults;
  end
  
  methods(Static)
    test();
    
  end
end

