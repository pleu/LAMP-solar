epsilon2 = 1; % air
frequency = linspace(0, 1.2); % omega_over_omega_p

% light line
waveVector = sqrt(epsilon2) *frequency;

figure(1);
clf;
plot(waveVector, frequency, 'b')

waveVector = frequency.*sqrt( (frequency.^2-1)*epsilon2./((frequency.^2-1)+...
  epsilon2*frequency.^2));


hold on;
plot(real(waveVector), frequency, 'bo')
plot(imag(waveVector), frequency, 'b.')

epsilon2 = 2.25; % silica

waveVector = sqrt(epsilon2) *frequency;
plot(waveVector, frequency, 'g')

waveVector = frequency.*sqrt( (frequency.^2-1)*epsilon2./((frequency.^2-1)+...
  epsilon2*frequency.^2));

hold on;
plot(real(waveVector), frequency, 'go')
plot(imag(waveVector), frequency, 'g.')


axis([0 3 0 1.2])

legend('air', '\omega_{sp, air}, real', '\omega_{sp, air}, imaginary', 'silica', '\omega_{sp, silica}, real', '\omega_{sp, silica}, imaginary', 'Location', 'Southeast')
legend('boxoff')
xlabel('wavevector (\beta c/\omega_p)');
ylabel('frequency (\omega/\omega_p)');