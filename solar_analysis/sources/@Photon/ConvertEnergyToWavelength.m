function [wavelength] = ConvertEnergyToWavelength(energy)
  % converts from eV to nm 
  wavelength = Constants.LightConstants.HC./energy; 
end

