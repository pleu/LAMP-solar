FDTD = load('a-Si (Silicon) - Palik (FDTD).txt');
raw = load('a-Si (Silicon) - Palik (raw).txt');

%FDTD(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  %(FDTD(:,1)*Constants.UnitConversions.THztoHz);
FDTD(:,1) = Constants.LightConstants.HC*10./FDTD(:,1);
%raw(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  %(raw(:,1)*Constants.UnitConversions.THztoHz);
raw(:,1) = Constants.LightConstants.HC*10./raw(:,1);

figure(1);
multiplot_add_wavelength_top_axis({FDTD(:,1)}, {FDTD(:,2)});
plot(FDTD(:,1),FDTD(:,2),'k-','LineWidth',3);
hold on;
plot(FDTD(:,1),raw(:,2),'ro','LineWidth',2);
xlabel('Energy (eV)');
ylabel('n');
legend('FDTD fit','Palik Volume 1');
axis([0.619 4.44 3 6]);

figure(2);
multiplot_add_wavelength_top_axis({FDTD(:,1)},{FDTD(:,3)});
semilogy(FDTD(:,1),FDTD(:,3),'k-','LineWidth',3);
hold on;
semilogy(FDTD(:,1),raw(:,3),'ro','LineWidth',2);
xlabel('Energy (eV)');
ylabel('k');
axis([0.619 4.44 0 3]);
legend('FDTD fit','Palik Volume 1');

FDTD(:, 1) = FDTD(:, 1)*Constants.UnitConversions.NMtoA;
raw(:, 1) = raw(:, 1)*Constants.UnitConversions.NMtoA;


