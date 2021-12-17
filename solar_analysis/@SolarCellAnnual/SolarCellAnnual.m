classdef SolarCellAnnual < handle
% SolarCell class for solar cell
%
% See also SolarSpectrum, MaterialData
% 
% Copyright 2011
% Paul Leu 
  properties
    RadiationBeam;
    Structure; % this must be an Absorber
  end
  
  methods    
    function sc = SolarCell(solarSpectrum, structure)
      if nargin > 0
          sc.SolarSpectrum = solarSpectrum;
          sc.Structure = structure;
          sc.Material = material;
      end
      
    end
    
  end
end