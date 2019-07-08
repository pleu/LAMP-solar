function [normalizedIntensity] = calc_normalized_intensity(obj, wavelength, kx)

diffractionPatternX = obj.OneDSlitX.calc_diffraction_pattern(wavelength, kx); 
diffractionPatternY = obj.OneDSlitY.calc_diffraction_pattern(wavelength, kx); 

normalizedIntensity = diffractionPatternY.NormalizedIntensity'*diffractionPatternX.NormalizedIntensity;

end


