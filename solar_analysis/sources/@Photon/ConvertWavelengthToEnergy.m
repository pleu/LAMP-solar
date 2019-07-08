function [energy] = ConvertWavelengthToEnergy(wavelength)
% convert wavelength in nm to energy in ev 
  energy = Constants.LightConstants.HC./wavelength;
end
