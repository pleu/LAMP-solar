clear;
ss = SolarSpectrum.global_AM1p5;
limitingEfficiency = zeros(ss.NumWavelength, 1);
currentSC = zeros(ss.NumWavelength, 1);
toPercent = 100;
IV = SolarCellIV.empty(ss.NumWavelength, 0);

for ind = 1:ss.NumWavelength
  bandGap = ss.Energy(ind);
  energyInd = find(ss.Energy >= bandGap);
  if size(energyInd, 1) > 1
    currentSC(ind) = -Constants.LightConstants.Q*...
      trapz(ss.Energy(energyInd),...
      ss.PhotonFlux(energyInd));
    IV(ind) = SolarCellIV.calc_IV2(bandGap, currentSC(ind), ss);
    limitingEfficiency(ind) = IV(ind).Efficiency;
  else
    limitingEfficiency(ind) = 0;
  end
end
  
figure(1)
clf;
% limitingEfficiency = limitingEfficiency/obj.PowerDensity;
optionplot(ss.Energy, limitingEfficiency*toPercent);
xlabel('Band Gap (eV)');
ylabel('Limiting Efficiency (%)');


figure(2)
clf;
optionplot(ss.Energy, currentSC);
ylabel('Short Circuit Current (Amps/m^2)');
xlabel('Band Gap (eV)');

figure(3)
clf;
optionplot(ss.Energy(2:end), [IV.VOC]);
ylabel('Open Circuit Voltage (Volts)');
xlabel('Band Gap (eV)');
