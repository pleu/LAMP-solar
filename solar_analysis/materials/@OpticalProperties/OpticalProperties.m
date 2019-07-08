classdef OpticalProperties < handle
% OPTICALPROPERTIES class for material properties
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  properties
    Filename;   %
    OpticalPhoton;    
    N;          % real part of refractive index 
    K;          % imaginary part of refractive index        
  end
  
  properties (Dependent = true)
    Wavelength;        % in nm
    Wavenumber;        % k (in 1/nm)
    Energy;            % in eV
    Frequency;         % in 1/sec
    AngularFrequency;  % in rad/sec
    
    Alpha;             % absorption coefficient in 1/nm; assumes non-magnetic
                       % media
    RefractiveIndex;   % complex number; use convention RefraciveIndex = n - ik, 
                       % where k > 0 corresponds to loss
    AbsorptionLength;  % in nm
    
    Epsilon1;          % real part of dielectric constant
    Epsilon2;          % imaginary part of dielectric constant; dielectric constant
    % is epsilon1 + i*epsilon2;
  end
  
  methods
    function obj = OpticalProperties(material, wavelength)
      if nargin == 0
        [wavelength, obj.N, obj.K] = obj.read_optical_constants('Si');
        obj.OpticalPhoton = Photon(wavelength);
        obj.Filename = 'Si';
      elseif nargin == 1
        [wavelength, obj.N, obj.K] = obj.read_optical_constants(material);
        obj.OpticalPhoton = Photon(wavelength);
        obj.Filename = material;
      else
        obj.Filename = material;
        [wavelengthData, nData, kData] = obj.read_optical_constants(material);
        obj.OpticalPhoton(wavelength) = wavelength;
        obj.N = interp1(wavelengthData, nData, wavelength);
        obj.K = interp1(wavelengthData, kData, wavelength);
      end
    end
    
    function remove_infinite_wavelengths(obj)
      index = ~isinf(obj.Wavelength);
      obj.Wavelength = obj.Wavelength(index);
      obj.N = obj.N(index);
      obj.K = obj.K(index);
    end
    
    function absorptionLength = get.AbsorptionLength(obj)
      absorptionLength = 1./obj.Alpha;
    end
    
    function set.Wavelength(obj, wavelength)
      obj.OpticalPhoton.Wavelength = wavelength; 
    end
    
    
    function set.AngularFrequency(obj, angularFrequency)
      obj.OpticalPhoton.AngularFrequency = angularFrequency; 
    end

    
    function wavelength = get.Wavelength(obj)
      wavelength = obj.OpticalPhoton.Wavelength;
    end
    
    function wavenumber = get.Wavenumber(obj)
      wavenumber = obj.OpticalPhoton.Wavenumber;
    end
    
    function frequency = get.Frequency(obj)
      frequency = obj.OpticalPhoton.Frequency;
    end
    
    function angularFrequency = get.AngularFrequency(obj)
      angularFrequency = obj.OpticalPhoton.AngularFrequency;
    end
    
    function refractiveIndex = get.RefractiveIndex(obj)
      refractiveIndex = obj.N - 1i*obj.K;
    end
    
    function energy = get.Energy(obj)
      energy = obj.OpticalPhoton.Energy; 
    end
    
    function alpha = get.Alpha(obj)
      alpha = 2*obj.K.*obj.AngularFrequency./Constants.LightConstants.C.*...
        Constants.UnitConversions.NMtoM; % in nm
    end 
    
    function [obj] = set_epsilon(obj, epsilon1, epsilon2)
      obj.N = sqrt((sqrt(epsilon1.^2 + epsilon2.^2)+epsilon1)/2);
      obj.K = sqrt((sqrt(epsilon1.^2 + epsilon2.^2)-epsilon1)/2);
    end
    
    function epsilon1 = get.Epsilon1(obj)
      epsilon1 = (obj.N).^2 - (obj.K).^2;
    end
    
    function epsilon2 = get.Epsilon2(obj)
      epsilon2 = 2 * obj.N .* obj.K;
    end
    
  end
    
  methods(Static)
    [K] = ConvertAlphaToK(alpha, frequency)

    function [obj] = create_constant_epsilon(epsilon1, epsilon2, omega)
      if size(omega, 2) > 1
        omega = omega';
      end
      if nargin == 1
        epsilon2 = 0;
      elseif nargin == 2
        epsilon2 = 0;
        obj = OpticalProperties('air');
        [obj] = obj.set_epsilon([epsilon1; epsilon1], [epsilon2; epsilon2]);
      else
        obj = OpticalProperties('air');
        obj.AngularFrequency = omega;
        [obj] = obj.set_epsilon(epsilon1*ones(length(omega),1), epsilon2*ones(length(omega), 1));
      end
      
      
      %wavelength = [1 10000];
      %obj.K = [0 0];
      %obj.OpticalPhoton = Photon(wavelength);      
      obj.Filename = 'constant';
    end

    function [obj] = create_Drude(omega_p, omega, gamma)
      if nargin == 2
        gamma = 0;
      end
      obj = OpticalProperties('air');
      if size(omega, 2) > 1
        omega = omega';
      end
      obj.AngularFrequency = omega;

      [obj] = obj.set_epsilon(1 - omega_p^2./(omega.^2 + 1i*gamma*omega), 0);
      obj.Filename = 'Drude';
    end
    
    function [obj] = create_constant_index(index)
      obj = OpticalProperties('air');
      %wavelength = [1 10000];
      obj.N = [index; index];
      %obj.K = [0 0];
      %obj.OpticalPhoton = Photon(wavelength);      
      obj.Filename = 'constant';
    end

    [wavelength, n, k] = read_optical_constants(material)
    
  
    y = spp(k, op1, op2, rhs)
    test_spp3();
    test_spp2();

    test_sp();
    test_spp();
    test();
    
    test_calc_spp_dispersion;
    test_calc_spp_wavevector_from_wavelength;
    
  end
  
  

end

