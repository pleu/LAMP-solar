%a = 1500;
a = 750;
lambda_p = a/5.43;
omega_p = 2*pi*Photon.ConvertWavelengthToFrequency(lambda_p);
%op(1) = OpticalProperties('Ag (Silver) - Johnson and Christy (raw)');
%op(1) = OpticalProperties('Cu (Copper) - CRC (FDTD)');

omega = linspace(1.8837e14, 1.8837e19);

op(1) = OpticalProperties.create_Drude(omega_p, omega);
op(2) = OpticalProperties('air');

[lambdaResonances] = calculate_spp_modes_square_lattice(op, a)

lambdaResonances


omega = 2*pi*Photon.ConvertFrequencyToWavelength(lambdaResonances);