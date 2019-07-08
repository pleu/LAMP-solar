% FDTD = load('Ag (Silver) - Palik (FDTD).txt');
% raw = load('Ag (Silver) - Palik (raw).txt');
filename = 'Ag (Silver) - Johnson and Christy';

FDTD = load([filename, ' (FDTD).txt']);
raw = load([filename, ' (raw).txt']);


FDTD(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  (FDTD(:,1)*Constants.UnitConversions.THztoHz);
raw(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  (raw(:,1)*Constants.UnitConversions.THztoHz);


figure(1);
plot(FDTD(:,1),FDTD(:,2),'k-','LineWidth',2);
hold on;
plot(FDTD(:,1),raw(:,2),'ro','LineWidth',1);
xlabel('Wavelength (nm)');
ylabel('n');
legend('FDTD','raw');
axis([280 1000 0 2]);

figure(2);
plot(FDTD(:,1),FDTD(:,3),'k-','LineWidth',2);
hold on;
plot(FDTD(:,1),raw(:,3),'ro','LineWidth',1);
xlabel('Wavelength (nm)');
ylabel('k');
axis([280 1000 0 10]);
legend('FDTD','raw');

FDTD(:, 1) = FDTD(:, 1)*Constants.UnitConversions.NMtoA;
raw(:, 1) = raw(:, 1)*Constants.UnitConversions.NMtoA;

save([filename, ' (FDTD)2.txt'], 'FDTD', '-ascii');
save([filename, ' (raw)2.txt'], 'raw', '-ascii');

