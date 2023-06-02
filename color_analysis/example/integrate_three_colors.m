function [x_out, y_out, z_out] = integrate_three_colors(illumination, reflection, x_bar, y_bar, z_bar)

x = integrate_color(illumination, reflection, x_bar);
y = integrate_color(illumination, reflection, y_bar);
z = integrate_color(illumination, reflection, z_bar);

x_out = x/(x+y+z);
y_out = y/(x+y+z);
z_out = z/(x+y+z);

