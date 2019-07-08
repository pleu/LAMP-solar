clear;
op(1) = OpticalProperties('Ag (Silver) - Johnson and Christy (raw)');
%op(1) = OpticalProperties('Ag (Silver) - Johnson and Christy (FDTD)');
op(2) = OpticalProperties('Air');

wavelength = 450;
[beta, k_z, L, z_hat, z_1, z_2] = op.calc_spp_wavevector_from_wavelength(wavelength);






wavelength = 200:1500;
[beta, k_z, L, z_hat] = op.calc_spp_wavevector_from_wavelength(wavelength);

figure(1);
clf;
plot(wavelength, L);
figure(2);
clf;
plot(wavelength, z_hat, 'g--');