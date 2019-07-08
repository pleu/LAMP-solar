function [q, h, qbar] = calculate_q_h(beta, op1, op2, k)


  complexK = complex(k(:, 1), k(:, 2));
  
  % outside semiconductor
%   n_r1 = interp1(op1.Wavelength, op1.N, 2*pi./k(:, 1));
%   n_k1 = interp1(op1.Wavelength, op1.K, 2*pi./k(:, 1));
%   n1 = n_r1 - sqrt(-1)*n_k1;
%   
  n1 = interp1(op1.Wavelength, op1.N, 2*pi./k(:, 1));
  
  % inside semiconductor
%   n_r2 = interp1(op2.Wavelength, op2.N, 2*pi./k(:, 1));
%   n_k2 = interp1(op2.Wavelength, op2.K, 2*pi./k(:, 1));
%   n2 = n_r2 - sqrt(-1)*n_k2;
  n2 = interp1(op2.Wavelength, op2.N, 2*pi./k(:, 1));
  %q = sqrt(beta.^2 - (n1.*complexK).^2);
  q = sqrt((n1.*complexK).^2 - beta.^2);
  h = sqrt((n2.*complexK).^2 - beta.^2);
  if nargout == 3
    qbar = n2.^2./n1.^2.*q;
  end
end