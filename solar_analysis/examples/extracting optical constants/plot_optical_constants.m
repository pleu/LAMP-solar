%op(1) = OpticalProperties('Ag (Silver) - Palik (FDTD)');
%op(2) = OpticalProperties('Ag (Silver) - Palik (raw)');

%op(1) = OpticalProperties('Au (Gold) - CRC (FDTD)');
%op(2) = OpticalProperties('Au (Gold) - CRC (raw)');

op(1) = OpticalProperties('Cu (Copper) - CRC (FDTD)');
op(2) = OpticalProperties('Cu (Copper) - CRC (raw)');

%op(1) = OpticalProperties('Si3N4 (raw)');
%op(2) = OpticalProperties('SiO2glass');

%op(1) = OpticalProperties('a-Si (Silicon) - Palik (FDTD)');
%op(2) = OpticalProperties('a-Si (Silicon) - Palik (raw)');

%op(1) = OpticalProperties('Si (Silicon) - Palik (FDTD)');
%op(1) = OpticalProperties('Si (Silicon) - Palik (FDTD)');

%op(2) = OpticalProperties('Si3N4 (FDTD)');
%op(3) = OpticalProperties('Si3N4 (raw)');

%op(1) = OpticalProperties('PbS_constant_2nd');

%op(2) = OpticalProperties('PbS_constant_2nd');

%op(1).Wavelength = op(1).Wavelength;
%op(2).Wavelength = op(2).Wavelength;
figure(1)
clf;

op(1).plot_refractive_index_versus_wavelength('Color', 'b')
hold on;
op(1).plot_imag_refractive_index_versus_wavelength('Color', 'g', 'LineStyle', ':');
axis([0 400 0 7]);
%plot(op(1).Wavelength, op(1).N)
%plot(op(1).Energy, op(1).N)
%hold on;
%plot(op(1).Energy, op(1).K, 'r--')
%plot(op(1).Wavelength, op(1).K, 'r--')


%axis([0 1200 0 2.4])
%hold on;
figure(2);
clf;
op(2).plot_refractive_index_versus_wavelength('Color', 'b')
hold on;
op(2).plot_imag_refractive_index_versus_wavelength('Color', 'g', 'LineStyle', ':');
axis([0 4000 0 2.4]);

%plot(op(2).Wavelength, op(2).N, 'g')
%ylabel('n')
%xlabel('Wavelength (nm)')
%xlabel('Energy (eV)')

%axis([0 1200 0 2.4])


% hold on;
% figure(2)
% plot(op(1).Energy, op(1).K, 'g')
% 
% xlabel('Energy (eV)')
% %hold on;
% %plot(op(2).Wavelength, op(2).K, 'go')
% %ylabel('k')
% %xlabel('Wavelength (nm)')
% 
% 
% figure(3)
% %plot(op(1).Wavelength, op(1).Epsilon1, 'r')
% hold on;
% %plot(op(2).Wavelength, op(2).Epsilon1, 'ro')
% ylabel('eps_1')
% 
% hold on;
% figure(4)
% plot(op(1).Wavelength, op(1).Epsilon2, 'c')
% hold on;
% plot(op(2).Wavelength, op(2).Epsilon2, 'co')
% ylabel('eps_2')
% 
% figure(5)
% plot(op(1).Wavelength, 2*op(1).AbsorptionLength);
% ylabel('skin depth (nm)')
% %op.plot_absorption_length_versus_wavelength;
% 
% figure(6)
% loss = op(1).Epsilon2./(op(1).Epsilon1.^2 + op(1).Epsilon2.^2);
% plot(op(1).Wavelength, loss, 'b');
% [maxVal, ind] = max(loss);
% op(1).Wavelength(ind)
