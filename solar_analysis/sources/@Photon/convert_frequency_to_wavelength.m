function [wavelength] = ConvertFrequencyToWavelength(frequency)
  % Convert frequency in 1/sec to Wavelength in nm
  wavelength = Constants.LightConstants.C./frequency*Constants.UnitConversions.NMperM; 
end

