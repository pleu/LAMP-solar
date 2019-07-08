function y = spp(k, op1, op2, rhs)

complexK = complex(k(:, 1), k(:, 2));

epsilon_Si_r = interp1(op1.Wavelength, op1.Epsilon1, 2*pi./k(:, 1));
epsilon_Si_i = interp1(op1.Wavelength, op1.Epsilon2, 2*pi./k(:, 1));

epsilon_Si = epsilon_Si_r+sqrt(-1)*epsilon_Si_i;

epsilon_Ag_r = interp1(op2.Wavelength, op2.Epsilon1, 2*pi./k(:, 1));
epsilon_Ag_i = interp1(op2.Wavelength, op2.Epsilon2, 2*pi./k(:, 1));

epsilon_Ag = epsilon_Ag_r+sqrt(-1)*epsilon_Ag_i;

%k = 2*pi/complexX;
complexY = rhs - complexK.*sqrt((epsilon_Si.*epsilon_Ag)./(epsilon_Si+epsilon_Ag));
y = [real(complexY) imag(complexY)];