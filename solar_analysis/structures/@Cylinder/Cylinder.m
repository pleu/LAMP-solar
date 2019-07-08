classdef Cylinder
  %UNTITLED2 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Material;      % MaterialType object
    Radius;      % diameter in nm
  end
  
  methods
    function cy = Cylinder(material, radius)
      if nargin ~= 0
        cy.Material = material;
        cy.Radius = radius;
      end
    end
    
%    function [q, h, n1, n2] = calculate_q_h(beta, op1, op2, k)
  end
  
  
  methods(Access=protected,Static)
    function complexY = leaky_mode_TM(k, nu, beta, op1, op2, radius)
      % these modes are leaky TM
      [h, q, n1, n2] = Cylinder.calculate_q_h(beta, op1, op2, k);
      ha = h*radius; % inside cylinder
      qa = q*radius; % outside cylinder      
      besseljPrime = 1/2*(besselj(nu-1,ha)-besselj(nu+1,ha));
      besselHPrime = 1/2*(besselh(nu-1,qa)-besselh(nu+1,qa));
      complexY = ...
        (n1.*besseljPrime./(besselj(nu,ha))-n2.*besselHPrime./(besselh(nu,qa)));
      %y = [real(complexY) imag(complexY)];
    end

    function y = leaky_mode_TE_real(k, nu, beta, op1, op2, radius)
      % these modes are leaky TM
      [h, q, n1, n2] = Cylinder.calculate_q_h_real(beta, op1, op2, k);
      ha = h*radius; % inside cylinder
      qa = q*radius; % outside cylinder      
      besseljPrime = 1/2*(besselj(nu-1,ha)-besselj(nu+1,ha));
      besselHPrime = 1/2*(besselh(nu-1,qa)-besselh(nu+1,qa));
      complexY = ...
        (besseljPrime./(n1.*besselj(nu,ha))-besselHPrime./(n2.*besselh(nu,qa)));
      y = real(complexY);
    end

    
    function complexY = leaky_mode_TE(k, nu, beta, op1, op2, radius)
      % these modes are leaky TM
      [h, q, n1, n2] = Cylinder.calculate_q_h(beta, op1, op2, k);
      ha = h*radius; % inside cylinder
      qa = q*radius; % outside cylinder      
      besseljPrime = 1/2*(besselj(nu-1,ha)-besselj(nu+1,ha));
      besselHPrime = 1/2*(besselh(nu-1,qa)-besselh(nu+1,qa));
      complexY = ...
        (besseljPrime./(n1.*besselj(nu,ha))-besselHPrime./(n2.*besselh(nu,qa)));
      %y = [real(complexY) imag(complexY)];
    end
    
    
    function complexY = leaky_mode(k, nu, beta, op1, op2, radius)
      % these modes are leaky
      [h, q, n1, n2] = Cylinder.calculate_q_h(beta, op1, op2, k);
      ha = h*radius; % inside cylinder
      qa = q*radius; % outside cylinder      
      besseljPrime = 1/2*(besselj(nu-1,ha)-besselj(nu+1,ha));
      besselHPrime = 1/2*(besselh(nu-1,qa)-besselh(nu+1,qa));
      complexY = (1./(h.^2-q.^2)).^2.*(beta*nu./(k*radius)).^2-...
        (n1.^2.*besseljPrime./(h.*besselj(nu,ha))-n2.^2.*besselHPrime./(q.*besselh(nu,qa))).*...
        (besseljPrime./(h.*besselj(nu,ha))-besselHPrime./(q.*besselh(nu,qa)));
      %y = [real(complexY) imag(complexY)];
%       complexY_TM = ...
%         (n1.*besseljPrime./(besselj(nu,ha))-n2.*besselHPrime./(besselh(nu,qa)));
%       complexY_TE = ...
%         (besseljPrime./(n1.*besselj(nu,ha))-besselHPrime./(n2.*besselh(nu,qa)));
    end
    
    function complexY = guided_mode(k, nu, beta, op1, op2, radius)
      % these modes are bound
      [h, q, n1, n2] = Cylinder.calculate_q_h(beta, op1, op2, k);
      ha = h*radius; % inside cylinder
      qa = q*radius; % outside cylinder      
      besseljPrime = 1/2*(besselj(nu-1,ha)-besselj(nu+1,ha));
      besselHPrime = 1/2*(besselh(nu-1,qa)-besselh(nu+1,qa));
      complexY = (1./(h.^2+q.^2)).^2.*(beta*nu./(k*radius)).^2-...
        (n1.^2.*besseljPrime./(h.*besselj(nu,ha))+n2.^2.*besselHPrime./(q.*besselh(nu,qa))).*...
        (besseljPrime./(h.*besselj(nu,ha))+besselHPrime./(q.*besselh(nu,qa)));
      %y = [real(complexY) imag(complexY)];
    end
  end
  methods(Static)
    Linyou();
    
    [q, h, n1, n2] = calculate_q_h(beta, op1, op2, k)
    [q, h, n1, n2] = calculate_q_h_real(beta, op1, op2, k)
    
    Catrysse();
    Catrysse_Fig4();
    
    test();
    test2();
    [y] = simple_test(x);
    [y] = simple_test2(x);
  end
    
  
end

