function [h, q, n1, n2] = calculate_q_h_real(beta, op1, op2, k)

  n1 = interp1(op1.Wavelength, op1.N, 2*pi./k);
  n2 = interp1(op2.Wavelength, op2.N, 2*pi./k);
  h = sqrt((n1.*k).^2 - beta.^2);
  q = sqrt((n2.*k).^2 - beta.^2);
end