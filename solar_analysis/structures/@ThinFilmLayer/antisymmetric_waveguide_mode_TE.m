function y = antisymmetric_waveguide_mode_TE(k, beta, op1, op2, thickness)

[q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);

% antisymmetric modes
% complexY = h.*cot(1/2*h*thickness) - q;
complexY = cot(1/2*h*thickness) - q./h;

y = [real(complexY) imag(complexY)];

end