function [q, h, qbar] = calculate_q_h_Yariv(beta, op1, op2, k)
% outside semiconductor
complexK = complex(k(:, 1), k(:, 2));
n1 = interp1(op1.Wavelength, op1.N, 2*pi./k(:, 1));

% inside semiconductor
n2 = interp1(op2.Wavelength, op2.N, 2*pi./k(:, 1));

%q = sqrt(beta.^2 - (n1.*complexK).^2);
q = sqrt(beta.^2-(n1.*complexK).^2);
h = sqrt((n2.*complexK).^2 - beta.^2);
if nargout == 3
  qbar = n2.^2./n1.^2.*q;
end
end