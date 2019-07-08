FDTD = load('Ag (Silver) - Palik (FDTD).txt');
raw = load('Ag (Silver) - Palik (raw).txt');

FDTD(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  (FDTD(:,1)*Constants.UnitConversions.THztoHz);

raw(:,1) = Constants.UnitConversions.MtoNM*(Constants.LightConstants.C)./...
  (raw(:,1)*Constants.UnitConversions.THztoHz);