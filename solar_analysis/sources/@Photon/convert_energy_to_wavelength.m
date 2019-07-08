function [wavelength] = convert_energy_to_wavelength(energy)
  % converts from eV to nm 
  wavelength = Constants.LightConstants.HC./energy; 
end

