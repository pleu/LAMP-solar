function [frequency] = ConvertWavelengthToFrequency(wavelength)
  % convert to 1/sec;
  % frequency = 2*pi*Constants.LightConstants.C./wavelength*NMperM; % rad/sec
  frequency = Constants.LightConstants.C./wavelength*...
    Constants.UnitConversions.NMperM;
end

