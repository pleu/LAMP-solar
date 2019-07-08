classdef Nanosphere
  %NANOSPHERE Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    MaterialData;   % MaterialData object
    Diameter;      % diameter in nm
  end
  
  properties (SetAccess = private, Dependent = true)
    NumDiameter; 
  end
  
  
  
  methods(Access=protected,Static)
    function eqn = TM_mode(k, op, radius, nu)
      
      complexK = complex(k(:, 1), k(:, 2));
      
      n_r = interp1(op.Wavelength*1e-9, op.N, 2*pi./k(:, 1));
      n_k = interp1(op.Wavelength*1e-9, op.K, 2*pi./k(:, 1));
      
      n = n_r - sqrt(-1)*n_k;
      
      eqn_TM = n.*ric_besselj(nu, n.*complexK*radius)'./ric_besselj_derivative(nu, n.*complexK*radius)'- ...
        ric_besselh(nu, 1, complexK*radius)'./ric_besselh_derivative(nu, 1, complexK*radius)';
      
      eqn = [real(eqn_TM) imag(eqn_TM)];
      
    end 
    
    
    function eqn = TE_mode(k, op, radius, nu)
      
      complexK = complex(k(:, 1), k(:, 2));
      
      n_r = interp1(op.Wavelength*1e-9, op.N, 2*pi./k(:, 1));
      n_k = interp1(op.Wavelength*1e-9, op.K, 2*pi./k(:, 1));
      
      n = n_r - sqrt(-1)*n_k;
      
      eqn_TE = ric_besselj(nu,n.*complexK*radius)'./ric_besselj_derivative(nu, n.*complexK*radius)' - ...
        n.*ric_besselh(nu, 1, complexK*radius)'./ric_besselh_derivative(nu,1, complexK*radius)';
            
      eqn = [real(eqn_TE) imag(eqn_TE)];
      
    end
    
  end
  
  
  
  
  methods
    
    function numDiameter = get.NumDiameter(obj)
      numDiameter = length(obj.Diameter);
    end
    
    function ns = Nanosphere(material, diameter)
      if nargin ~= 0
        ns.MaterialData = material;
        ns.Diameter = diameter;
      end

    end

    


  end
  
  methods(Static)
    test();
    
    test2();
  end
  
end

