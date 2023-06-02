function [x, y, z] = integrate_three_colors(illumination, reflection, x_bar, y_bar, z_bar)

x = integrate_color(illumination, reflection, x_bar);
y = integrate_color(illumination, reflection, y_bar);
z = integrate_color(illumination, reflection, z_bar);

x = x/(x+y+z);
y = y/(x+y+z);
z = z/(x+y+z);