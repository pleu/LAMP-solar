function [h, q, n1, n2] = calculate_q_h(beta, op1, op2, k)

  %complexK = complex(k(:, 1), k(:, 2));
  %     n1 = interp1(op1.Wavelength, op1.N, 2*pi./k(:, 1));
  %   n2 = interp1(op2.Wavelength, op2.N, 2*pi./k(:, 1));
  %   h = sqrt((n1.*complexK).^2 - beta.^2);
  %   q = sqrt((n2.*complexK).^2 - beta.^2);

  realK = real(k);
  %n1 = interp1(op1.Wavelength, op1.N, 2*pi./realK);
  %n2 = interp1(op2.Wavelength, op2.N, 2*pi./realK);
  n1 = interp1(op1.Wavelength, op1.RefractiveIndex, 2*pi./realK);
  n2 = interp1(op2.Wavelength, op2.RefractiveIndex, 2*pi./realK);
  h = sqrt((n1.*k).^2 - beta.^2);
  q = sqrt((n2.*k).^2 - beta.^2);
end