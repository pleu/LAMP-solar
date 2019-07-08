classdef ThinFilmLayer
% THINFILMLAYER class for single layer thin film
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh  
  properties
    Material;             % MaterialType object
    Thickness;      % thickness in nm
  end
  
  methods
    function tf = ThinFilmLayer(material, thickness)
      if nargin ~= 0
        tf.Material = material;
        tf.Thickness = thickness;
      end
    end

    function adjust_optical_properties(tf, wavelength)
      for i = 1:length(tf)
        tf(i).Material.adjust_optical_properties(wavelength);
      end
    end
    
    function n = get_N(tf, wavelength)
      n = zeros(length(wavelength), length(tf));
      for i = 1:length(tf)
        n(:, i) = tf(i).Material.get_n(wavelength);
      end
    end
    
    function material = get_material(tf)
      for i = 1:length(tf)
        material = tf(i).Material.Type;
      end
    end

    function refractiveIndex = get_refractive_index(tf, wavelength)
      refractiveIndex = zeros(length(wavelength), length(tf));
      for i = 1:length(tf)
        refractiveIndex(:, i) = tf(i).Material.get_refractive_index(wavelength);
      end
    end

    
    function k = get_K(tf, wavelength)
      k = zeros(length(wavelength), length(tf));
      for i = 1:length(tf)
        k(:, i) = tf(i).Material.get_k(wavelength);
      end
    end
    

  end
  
  
  methods(Access=protected,Static)
    
    function y = waveguide_mode_TE_even(k, beta, op1, op2, thickness)
      [q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      % symmetric modes
      complexY = sqrt(-1).*h.*tan(h*thickness/2);
%      complexY = tan(h*thickness/2) + sqrt(-1)*q./h;
%      complexY = tan(n2.*complexK*thickness/2) + sqrt(-1)*n2./n1;
      y = [real(complexY) imag(complexY)];
    end
    
    function y = waveguide_mode_TE_odd(k, beta, op1, op2, thickness)
      [q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      % antisymmetric modes
      complexY = h.*cot(1/2*h*thickness) - sqrt(-1).*q;
      y = [real(complexY) imag(complexY)];
    end
    
    

    function y = waveguide_mode_Yariv_TM(k, beta, op1, op2, thickness)
      [q, h, qbar] = ThinFilmLayer.calculate_q_h_Yariv(beta, op1, op2, k);
      %test = h.*tan(h.*thickness/2);
      complexY = tan(h*thickness) - 2*qbar.*h./(h.^2-qbar.^2);
      y = [real(complexY) imag(complexY)];
      %u = 1/2*h*thickness;
      %v = 1/2*q*thickness;
      %V = u.^2 + v.^2;
    end
    
    
    function y = guided_waveguide_mode_assymetric_TE(k,beta,op1,op2,op3,thickness)
      [q, h, p] = ThinFilmLayer.calculate_q_h_p_Yariv(beta, op1, op2, op3, k);
      complexY = tan(h*thickness) - (p+q)./(h.*(1 - p.*q./h.^2));
      y = [real(complexY) imag(complexY)];
    end
    
    function y = guided_waveguide_mode_assymetric_TM(k,beta,op1,op2,op3,thickness)
      [q, h, p, qbar, pbar] = ThinFilmLayer.calculate_q_h_p_Yariv(beta, op1, op2, op3, k);
      complexY = tan(h*thickness) - h.*(pbar+qbar)./(h.^2 - p.*q);
      y = [real(complexY) imag(complexY)];
    end

    
    %function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    function y = waveguide_mode_Yariv_TE(k, beta, op1, op2, thickness)
      [q, h] = ThinFilmLayer.calculate_q_h_Yariv(beta, op1, op2, k);
      %test = h.*tan(h.*thickness/2);
      complexY = tan(h*thickness) - 2*q.*h./(h.^2-q.^2);
      y = [real(complexY) imag(complexY)];
      %u = 1/2*h*thickness;
      %v = 1/2*q*thickness;
      %V = u.^2 + v.^2;
    end
    
    function y = waveguide_mode_on_metal_Yariv_TE(k, beta, op1, op2, thickness)      
      [q, h] = ThinFilmLayer.calculate_q_h_Yariv(beta, op1, op2, k);      
      complexY = cot(h*thickness) + q./h;
      y = [real(complexY) imag(complexY)];
    end
    
    function y = waveguide_mode_on_metal_Yariv_TM(k, beta, op1, op2, thickness)
      [q, h, qbar] = ThinFilmLayer.calculate_q_h_Yariv(beta, op1, op2, k);      
      %complexY = tan(h*thickness) - qbar./h;
      complexY = h.*tan(h*thickness) - qbar;
      y = [real(complexY) imag(complexY)];
    end

    
    
    
    function y = waveguide_mode_on_metal_TM(k, beta, op1, op2, thickness)
      [q, h, qbar] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      complexY = cot(h*thickness) - sqrt(-1).*h./qbar;
      y = [real(complexY) imag(complexY)];
      
    end
    
    %function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    function y = waveguide_mode_TE(k, beta, op1, op2, thickness)
      %complexK = complex(k(:, 1), k(:, 2));
      [q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      
      % symmetric modes
      %complexY = h.*tan(1/2*h*thickness) + q;
      complexY = tan(h*thickness) + 2*sqrt(-1)*q.*h./(q.^2+h.^2);
      y = [real(complexY) imag(complexY)];
      
    end
    
    function y = waveguide_mode_on_metal_TE(k, beta, op1, op2, thickness)
      
      [q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      
      %k = 2*pi/complexX;
      
      % TE modes
      
      complexY = cot(h*thickness) - sqrt(-1)*q./h;
      y = [real(complexY) imag(complexY)];
      
    end
    
    %function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    function y = waveguide_mode_TM(k, beta, op1, op2, thickness)
      %complexK = complex(k(:, 1), k(:, 2));
      [q, h, qbar] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);
      % symmetric modes
      %complexY = h.*tan(1/2*h*thickness) + q;
      complexY = tan(h*thickness) + 2*sqrt(-1)*qbar.*h./(qbar.^2+h.^2);
      y = [real(complexY) imag(complexY)];
      
    end
    
    
    %function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    function y = waveguide_mode_TE2(k, beta, op1, op2, thickness)
      %complexK = complex(k(:, 1), k(:, 2));
      [q, h] = ThinFilmLayer.calculate_q_h2(beta, op1, op2, k);
      
      % symmetric modes
      %complexY = h.*tan(1/2*h*thickness) + q;
      complexY = tan(h*thickness) + 2*sqrt(-1)*q.*h./(q.^2+h.^2);
      y = [real(complexY)];
      
    end


    
    
    
    
    
    function y = symmetric_waveguide_mode_TM_beta(u, V, n1, n2)
      complexU = complex(u(:, 1), u(:, 2));
      complexV = V.^2 - complexU.^2;
      
      complexY = complexU.*tan(complexU)-n2.^2/n1.^2*complexV;
      y = [real(complexY) imag(complexY)];
    end

    function y = antisymmetric_waveguide_mode_TM_beta(u, V, n1, n2)
      complexU = complex(u(:, 1), u(:, 2));
      complexV = V.^2 - complexU.^2;
      
      complexY = -complexU.*cot(complexU)-n2.^2/n1.^2*complexV;
      y = [real(complexY) imag(complexY)];
    end

    
    function y = symmetric_waveguide_mode_TE_beta(u, V)
      complexU = complex(u(:, 1), u(:, 2));
      complexV = V.^2 - complexU.^2;
      
      complexY = complexU.*tan(complexU)-complexV;
      y = [real(complexY) imag(complexY)];
    end
   
    function y = antisymmetric_waveguide_mode_TE_beta(u, V)
      complexU = complex(u(:, 1), u(:, 2));
      complexV = V.^2 - complexU.^2;
      
      complexY = -complexU.*cot(complexU)-complexV;
      y = [real(complexY) imag(complexY)];
    end
   
       
    
    function y = leaky_resonance_mode_2d_odd(k, op1, op2, thickness)

      complexK = complex(k(:, 1), k(:, 2));
      %op = OpticalProperties('Si (Silicon) - Palik (FDTD)');
      
      n_r1 = interp1(op1.Wavelength*1e-9, op1.N, 2*pi./k(:, 1));
      n_k1 = interp1(op1.Wavelength*1e-9, op1.K, 2*pi./k(:, 1));
      %n_r = 3.4;
      %n_k = 0;
      n1 = n_r1 - sqrt(-1)*n_k1;
      
      n_r2 = interp1(op2.Wavelength*1e-9, op2.N, 2*pi./k(:, 1));
      n_k2 = interp1(op2.Wavelength*1e-9, op2.K, 2*pi./k(:, 1));
      %n_r = 3.4;
      %n_k = 0;
      n2 = n_r2 - sqrt(-1)*n_k2;
      
      
      %k = 2*pi/complexX;
      complexY = cot(n2.*complexK*thickness/2) - sqrt(-1)*n2./n1;
      %complexY = tan(n.*complexK*thickness/2) + sqrt(-1)*n;
      y = [real(complexY) imag(complexY)];
    end

    
    
    
    
    
    
    
    
    function y = symmetric_waveguide_mode_TM(k, beta, op1, op2, thickness)
      
      complexK = complex(k(:, 1), k(:, 2));
      
      n_r = interp1(op.Wavelength, op.N, 2*pi./k(:, 1));
      n_k = interp1(op.Wavelength, op.K, 2*pi./k(:, 1));
      %n_r = 3.4;
      %n_k = 0;
      n = n_r - sqrt(-1)*n_k;
      
      h = sqrt((n.*complexK).^2 - beta^2);
      
      n_1 = ones(length(complexK), 1);
      q = sqrt(beta.^2 - (n_1.*complexK).^2);
      
      %k = 2*pi/complexX;
      
      % TE modes
      complexY = h.*cot(h*thickness) - q;
      y = [real(complexY) imag(complexY)];
      
      
    end
    
    
    
    
    
  
    
    
    
    

   
    
   
    
    
  end
  
  methods(Static)
    function tfArray = create_array(materials, thicknesses)
      tfArray = ThinFilmLayer.empty(length(thicknesses), 0);
      for i = 1:size(materials)
        mobj = MaterialType.create(char(materials(i)));
        tfArray(i) = ThinFilmLayer(mobj, thicknesses(i));
      end
    end
    
    
    
    
    y = leaky_resonance_mode_2d_on_metal(k, op1, op2, thickness)
    
    [q, h] = calculate_q_h2(beta, op1, op2, k)
    [q, h, qbar] = calculate_q_h(beta, op1, op2, k)
    [q, h, qbar] = calculate_q_h_Yariv(beta, op1, op2, k)

    y = leaky_resonance_mode_2d_even(k, op1, op2, thickness)
    
    y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    
    y = antisymmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
    
    test();
    
    test2();
    
    test2_2();
    
    test2_3();
    
    test3();
    
    test3_2();
    
    test4();
    
    test5();
    
    test6();
    
    Pala();
    
    Pala2();
    
    Gao_hemisphere();
    
    Yariv();
    
    Joannopoulos();
    
    test_calculate_waveguide_modes_metal();
    
    test2_calculate_waveguide_modes_metal();
  end
  
  
  
end

