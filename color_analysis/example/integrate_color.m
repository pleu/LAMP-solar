function [x] = integrate_color(illumination, reflection, x_bar)

min_wavelength = 380;
max_wavelength = 780;
wavlength_increment = 1;

wavelengths = min_wavelength:wavlength_increment:max_wavelength;

illumination_interp = interp1(illumination(:, 1), illumination(:, 2), wavelengths);
reflection_interp = interp1(reflection(:, 1), reflection(:, 2), wavelengths);
x_bar_interp = interp1(x_bar(:, 1), x_bar(:, 2), wavelengths);

x = trapz(wavelengths, illumination_interp.*reflection_interp.*x_bar_interp);




