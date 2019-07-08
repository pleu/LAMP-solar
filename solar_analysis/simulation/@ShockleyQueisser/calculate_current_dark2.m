function currentDark = calculate_current_dark2(sc, voltage, bandGap, absorptionResults)
% CALCULATE_CURRENT_DARK 
% Calculates dark current from solar spectrum given band gap
% 
% See also CALCULATE_CURRENT_SC
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  EVector = linspace(bandGap, max(sc.SolarSpectrum.Energy));
  absorption = interp1(absorptionResults.Energy, absorptionResults.Data, ...
    EVector, 'linear', 'extrap'); 
  absorption(absorption < 0) = 0;
  currentDark = zeros(1,size(voltage, 2));
  for ind = 1:size(voltage, 2)
    currentDark(ind) = Constants.LightConstants.Q ...
      *trapz(EVector, (SolarSpectrum.calculate_be(EVector, voltage(ind),...
      Constants.LightConstants.T_a, Constants.LightConstants.F_a) -...
      SolarSpectrum.calculate_be(EVector, 0, Constants.LightConstants.T_a,...
      Constants.LightConstants.F_a)).*absorption);
  end
%  if sc.IncludeAugerRecombination
%    currentDark = currentDark + sc.CurrentAuger;
%  end
end