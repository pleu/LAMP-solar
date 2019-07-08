%function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
function y = waveguide_mode_TM(k, beta, op1, op2, thickness)
%complexK = complex(k(:, 1), k(:, 2));
[q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);

n_r1 = interp1(op1.Wavelength*1e-9, op1.N, 2*pi./k(:, 1));
n_k1 = interp1(op1.Wavelength*1e-9, op1.K, 2*pi./k(:, 1));
n1 = n_r1 - sqrt(-1)*n_k1;

n_r2 = interp1(op2.Wavelength*1e-9, op2.N, 2*pi./k(:, 1));
n_k2 = interp1(op2.Wavelength*1e-9, op2.K, 2*pi./k(:, 1));
n2 = n_r2 - sqrt(-1)*n_k2;

qbar = n2.^2./n1.^2.*q;

% symmetric modes
%complexY = h.*tan(1/2*h*thickness) + q;
complexY = tan(h*thickness) + 2*sqrt(-1)*qbar.*h./(qbar.^2+h.^2);
y = [real(complexY) imag(complexY)];

end