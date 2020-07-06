classdef Reflector
% Reflector class for solar cell
%
% Copyright 2020
% Paul Leu 
  properties
    SolarSpectrum;
    Structure; % this must be a single structure
  end
  
  properties(Dependent = true)
    NumStructures;         % number of structures for 1 Transparent conductor
  end
  
  properties(SetAccess='private')
    ReflectionIntegrated;   % Structure must include an Reflection Results 
                            % variable     
  end
  
  
  methods    
    function rs = Reflector(solarSpectrum, structure)
      if nargin > 0
        rs.SolarSpectrum = solarSpectrum;
        rs.Structure = structure;
      end
        rs.ReflectionIntegrated = rs.calc_reflection_integrated;
    end
    
    function numStructures = get.NumStructures(r)
      numStructures = length(r.Structure);     
    end
    
    function reflectionIntegrated = calc_reflection_integrated(rs)      
      reflectionIntegratedArray = zeros(rs.NumStructures, 1);
      for i = 1:tc.NumStructures
        [reflectionIntegratedArray(i), warning] = ...
        SolarCell.calculate_integrated_data(rs.SolarSpectrum,...
        rs.Structure(i).ReflectionResults.Energy,...
        rs.Structure(i).ReflectionResults.Data); 
%         if(warning) 
%           disp(tc.Structure.Filename) 
%         end;
      end
      reflectionIntegrated = mean(reflectionIntegratedArray);        
    end
    
  end
end
