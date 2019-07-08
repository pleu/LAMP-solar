classdef DiffractionStructure < handle & matlab.System
  %DIFFRACTION Summary of this class goes here
  %   Detailed explanation goes here
  
  properties (Hidden)
     Symmetry;
%    DiffractionPattern;
%    Wavelength@double;
%    Theta@double;
%    NormalizedIntensity@double;
  end  
  
  
  
  properties (Hidden,Transient)
    % Let them choose a color
    SymmetrySet = matlab.system.StringSet({'1D','2D','Cylindrical'});
  end
  
  methods
%     function set.DiffractionPattern(obj, value)
%       if isa(value,'OneDDiffractionPattern')
%         obj.DiffractionPattern = value;
%       else
%         error('Structure should be of class OneDDiffractionPattern');
%       end
%     end

    
    
  end
  
    
  
end

