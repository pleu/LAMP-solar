function [jsc] = plot_limiting_efficiency_jsc_voc_versus_energy(obj, varargin)

for ind = 1:obj.NumWavelength
  bandGap = obj.Energy(ind);
  energyInd = find(obj.Energy >= bandGap);
  if size(energyInd, 1) > 1
    currentSC = -Constants.LightConstants.Q*...
      trapz(obj.Energy(energyInd),...
      obj.PhotonFlux(energyInd));
    IV = SolarCellIV.calc_IV2(bandGap, currentSC, obj);
    limitingEfficiency(ind) = IV.Efficiency;
  else
    limitingEfficiency(ind) = 0;
  end
  
end
  
figure(1)
% limitingEfficiency = limitingEfficiency/obj.PowerDensity;
optionplot(obj.Energy, limitingEfficiency, varargin);

figure(2)
optionplot(obj.Energy, limitingEfficiency, varargin);


xlabel('Band Gap (eV)');
ylabel('Limiting Efficiency');
end
