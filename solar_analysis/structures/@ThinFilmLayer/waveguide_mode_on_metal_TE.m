function y = waveguide_mode_on_metal_TE(k, beta, op1, op2, thickness)

[q, h] = ThinFilmLayer.calculate_q_h(beta, op1, op2, k);

%k = 2*pi/complexX;

% TE modes

complexY = cot(h*thickness) - sqrt(-1)*q./h;
y = [real(complexY) imag(complexY)];

end