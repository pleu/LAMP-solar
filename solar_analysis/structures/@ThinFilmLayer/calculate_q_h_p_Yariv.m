function [q, h, p, qbar, pbar] = calculate_q_h_p_Yariv(beta, op1, op2, op3, k)
% outside semiconductor
complexK = complex(k(:, 1), k(:, 2));

n1 = interp1(op1.Wavelength, op1.N, 2*pi./k(:, 1));

% inside semiconductor
n2 = interp1(op2.Wavelength, op2.N, 2*pi./k(:, 1));
n3 = interp1(op3.Wavelength, op3.N, 2*pi./k(:, 1));

%q = sqrt(beta.^2 - (n1.*complexK).^2);
q = sqrt(beta.^2-(n1.*complexK).^2);
h = sqrt((n2.*complexK).^2 - beta.^2);
p = sqrt(beta.^2-(n3.*complexK).^2);

if nargout == 5
  qbar = n2.^2./n1.^2.*q;
  pbar = n2.^2./n1.^2.*p;
end

end