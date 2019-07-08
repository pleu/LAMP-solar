op(1) = OpticalProperties('Ag (Silver) - Palik (0-2um) (FDTD)');
op(2) = OpticalProperties('Air');
%op(2) = OpticalProperties('Si (Silicon) - Palik (FDTD)');

rhs = 0;
lambdaResonances = calculate_spp_modes(op, rhs);