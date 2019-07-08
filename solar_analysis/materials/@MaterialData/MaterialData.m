classdef MaterialData 
% MATERIALDATA class for material properties
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  properties
    Material;
    OpticalProperties;
    BandGap = 0; %eV
  end
  properties (Dependent = true)
    Rho;       % bulk resistivity in Ohm-m
    WavelengthBandGap; %nm
    AugerCoefficient; %cm^6*sec^(-1)
    Ni; %cm^(-3), intrinsic carrier concentration
    Alpha_FreeCarrier; % free carrier absorption coefficient (needs to be
    % multipled by n, the electron density, and units is in (cm^-1)
  end
  
  methods
    
    function md = MaterialData(material) %, opticalProperties, bandGap)
      disp('Please use the newer MaterialType class if possible');
      md2 = MaterialType.create(material); %'Si';
      md.Material = md2.Type;
      md.OpticalProperties = md2.OpticalProperties;
      if any(strcmp('BandGap', properties(md2)))
        md.BandGap = md2.BandGap;  
      end
      %md@
%       if nargin == 0
%         
%         %md.OpticalProperties = OpticalProperties.empty(1, 0);
%         %md.BandGap = MaterialData.get_bandGap(md.Material);
%       elseif nargin == 1
%         md = md@MaterialType.create(material);
%         %md.OpticalProperties = OpticalProperties(md.Material);
        %md.BandGap = MaterialData.get_bandGap(md.Material);
%       elseif naragin == 2
%         %md.Material = material;
%         md = MaterialType.create(material);
%         md.OpticalProperties = opticalProperties; 
%         md.BandGap = MaterialData.get_bandGap(md.Material);
%       else
%         md.Material = material;
%         md.OpticalProperties = opticalProperties; 
%         md.BandGap = bandGap;
%       end
      %end
    end
    


    function rho = get.Rho(md)
      switch md.Material
        case 'Ag'
          rho = 1.58e-8;
        case 'Cu'
          rho = 1.68e-8;
        otherwise
          error('Unknown Material');
      end 
    end
    
    function alpha_FreeCarrier = get.Alpha_FreeCarrier(md)
      switch md.Material
        case 'Si'
          alpha_FreeCarrier = 5.5e-18;
        otherwise
          error('Unknown Material');
      end 
    end

    
    function augerCoefficient = get.AugerCoefficient(md)
      switch md.Material
        case 'Si'
          augerCoefficient = 3.88e-31;
        otherwise
          error('Unknown Material');
      end 
    end

    function ni = get.Ni(md)
      switch md.Material
        case 'Si'
          ni = 1.45e10;
        otherwise
          error('Unknown Material');
      end 
    end
    
    
    function wavelengthBandGap = get.WavelengthBandGap(md)
      wavelengthBandGap = Constants.LightConstants.HC/md.BandGap;
    end
  end
  
  methods(Static)
    bandGap = get_bandGap(material)
    
    test()
  end
end

