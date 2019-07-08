function ultimateEfficiency = calculate_ultimate_efficiency(sc,bandGap)
% CALCULATE_ULTIMATE_EFFICIENCY Calculates the ultimate efficiency for 
% sc.SolarSpectrum for a particular band gap
%
% Copyright, 2011
% Paul Leu
% LAMP, University of Pittsburgh
  bandGapIndex = find(sc.SolarSpectrum.Energy >= bandGap, 1, 'last');
  ultimateEfficiency = Constants.LightConstants.Q*bandGap * ...
    trapz(sc.SolarSpectrum.Energy(bandGapIndex:-1:1), ...
    sc.SolarSpectrum.PhotonFlux(bandGapIndex:-1:1))/ ...
    sc.SolarSpectrum.PowerDensity;
end
