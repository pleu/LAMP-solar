classdef DiffractionPattern < handle
  %DIFFRACTIONPATTERN Summary of this class goes here
  %   Detailed explanation goes here
  
  properties(Dependent)
    K@double;
    Wavelength@double;
  end
  
  properties
    Photon;
  end
  
%   properties(Access = 'protected')
%     Photon;
%   end

  methods
    
    function [wavelength] = get.Wavelength(obj)
      wavelength = obj.Photon.Wavelength;
    end
    
    function set.Wavelength(obj, value)
      obj.Photon.Wavelength = value;
    end
    
    function [k] = get.K(obj)
      k = obj.Photon.Wavenumber;
    end
    
    function set.K(obj, value)
      obj.Photon.Wavenumber = value;
    end
  end
  
end

