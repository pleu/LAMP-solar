function y = leaky_resonance_mode_2d_on_metal(k, op1, op2, thickness)

complexK = complex(k(:, 1), k(:, 2));
%op = OpticalProperties('Si (Silicon) - Palik (FDTD)');

n_r2 = interp1(op2.Wavelength*1e-9, op2.N, 2*pi./k(:, 1));
n_k2 = interp1(op2.Wavelength*1e-9, op2.K, 2*pi./k(:, 1));
%n_r = 3.4;
%n_k = 0;
n2 = n_r2 - sqrt(-1)*n_k2;

n_r1 = interp1(op1.Wavelength*1e-9, op1.N, 2*pi./k(:, 1));
n_k1 = interp1(op1.Wavelength*1e-9, op1.K, 2*pi./k(:, 1));
%n_r = 3.4;
%n_k = 0;
n1 = n_r1 - sqrt(-1)*n_k1;


%k = 2*pi/complexX;
complexY = tan(n2.*complexK*thickness) + sqrt(-1)*n2./n1;

y = [real(complexY) imag(complexY)];
end