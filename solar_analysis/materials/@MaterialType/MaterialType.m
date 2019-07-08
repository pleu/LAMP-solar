classdef MaterialType < handle
% MATERIALTYPE class for material properties
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  properties
    Type;
  end
  
  methods
    function adjust_optical_properties(mt, wavelength)
       mt.OpticalProperties.adjust_optical_properties(wavelength);
    end
    
    function n = get_n(mt, wavelength)
      n = mt.OpticalProperties.get_n(wavelength);
    end
    
    function refractiveIndex = get_refractive_index(mt, wavelength)
      refractiveIndex = mt.OpticalProperties.get_refractive_index(wavelength);
    end
  end
  
  methods(Access = protected)
    function mt = MaterialType(material)
      if nargin ~= 0
        mt.Type = material;
      end
    end   
  end
  
  methods(Static)    
    test()
    
    function obj = create(material) %#ok<STOUT>
      % factory method for creating materials
      try
        eval(['obj = ', material, ';']);
      catch me
        error([material, ' is currently not supported']);
      end      
    end
    
    
  end
  
end



