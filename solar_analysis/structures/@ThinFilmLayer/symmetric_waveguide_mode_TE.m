function y = symmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)
%complexK = complex(k(:, 1), k(:, 2));
[q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);

% symmetric modes
%complexY = h.*tan(1/2*h*thickness) + q;
complexY = tan(1/2*h*thickness) - q./h;
y = [real(complexY) imag(complexY)];

end
