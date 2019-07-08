clear;
op(1) = OpticalProperties('Ag (Silver) - Palik (0-2um) (FDTD)');
%op(2) = OpticalProperties('Air');
%op(2) = OpticalProperties('Si (Silicon) - Palik (FDTD)');
op(2) = OpticalProperties('ITO (FDTD)');

%wavelength = 200:1000;
[angularFrequency, beta] = op.calc_spp_dispersion;

figure(1);
clf;
optionplot(real(beta), angularFrequency, 'LineColor', 'b', 'LineStyle', '-');
hold on;
optionplot(imag(beta), angularFrequency, 'LineColor', 'g', 'LineStyle', '--');
xlabel('Beta')
ylabel('\omega')

figure(2);
clf;
optionplot(real(beta), Photon.convert_angular_frequency_to_wavelength(angularFrequency), 'Color', 'b', 'LineStyle', '--');
hold on;
optionplot(imag(beta), Photon.convert_angular_frequency_to_wavelength(angularFrequency), 'Color', 'g', 'LineStyle', '--');
%optionplot(imag(beta), angularFrequency, 'LineColor', 'g', 'LineStyle', '--');
xlabel('Beta (nm)')
ylabel('Wavelength (nm)')

