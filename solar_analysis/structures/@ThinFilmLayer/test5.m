% this attempts to generate Figure 2.3 in Maier

thickness = 100;
ma1 = MaterialType.create('Air');
ma1.OpticalProperties.create_constant_epsilon(1, 0)

ma2 = MaterialType.create('Air');
ma2.OpticalProperties = ma2.OpticalProperties.create_constant_epsilon(2.25, 0)

%ma.OpticalProperties = OpticalProperties('Si (Silicon) - Palik (FDTD)');
%tf = ThinFilmLayer(ma, thickness);

%k = linspace(0, 1.5);
figure(1);
clf;
%omega1 = 2*pi./ma1.OpticalProperties.Wavelength; 
plot(ma1.OpticalProperties.Wavenumber, ma1.OpticalProperties.AngularFrequency./ma1.OpticalProperties.N);
hold on;

%omega2 = ma2.OpticalProperties.N.*ma2.OpticalProperties.AngularFrequency; 
plot(ma2.OpticalProperties.Wavenumber, ma2.OpticalProperties.AngularFrequency./ma2.OpticalProperties.N, 'g');

xlabel('1/nm');

ma = MaterialType.create('Ag');
omega_p = 1e19;
%omegaMin = 0;
%omegaMax = 1.2;
omega = linspace(min(ma1.OpticalProperties.AngularFrequency), max(ma1.OpticalProperties.AngularFrequency), 1000);
ma3.OpticalProperties = OpticalProperties.create_Drude(omega_p, omega);




%tf(1) = ThinFilmLayer(ma1, thickness);
%tf(2) = ThinFilmLayer(ma3, thickness);
%k = linspace(0, 10);
op(1) = ma1.OpticalProperties;
op(2) = ma3.OpticalProperties;

[beta, k] = op.calculate_spp_dispersion();

plot(Photon.convert_wavenumber_to_angular_frequency(beta), Photon.convert_wavenumber_to_angular_frequency(k), 'r')
% 
% figure(2);
% clf;
% plot(ma1.OpticalProperties.AngularFrequency, ma1.OpticalProperties.Epsilon1)
% hold on;
% plot(ma2.OpticalProperties.AngularFrequency, ma2.OpticalProperties.Epsilon1, 'g')
% plot(ma3.OpticalProperties.AngularFrequency, ma3.OpticalProperties.Epsilon1, 'r')
% 
% omega = linspace(0, 100);
% omega_p = 40;
% epsilon = 1 - omega_p^2./omega.^2;
% figure(3);
% plot(omega, epsilon)
