clear;

%filename = 'reflection/Cylinder_top_G240_D100_H40_P500Reflection.txt';
filename = 'reflection/Cylinder_top_G240_D100_H160_P500Reflection.txt';
%filename_CIE = 'CIE/CIE_illum_C.csv';
filename_CIE = 'CIE/CIE_std_illum_D65.csv';
filename_xyz = 'color_matching/CIE_xyz_1931_2deg.csv';

%filename = 'reflection/Cylinder_top_G240_D100_H160_P500Reflection.txt';

reflection_data = load(filename);
illuminance_data = load(filename_CIE);

% wavelengths = 380:1:780;
% illuminance_data = [wavelengths' ones(length(wavelengths), 1)];

color_data = load(filename_xyz);


figure(1);
clf;
plot(reflection_data(:, 1), 100*reflection_data(:, 2));
hold on;
plot(illuminance_data(:, 1), illuminance_data(:, 2), 'g');

plot(color_data(:, 1), 100*color_data(:, 2:4));

x_bar = [color_data(:, 1), color_data(:, 2)];
y_bar = [color_data(:, 1), color_data(:, 3)];
z_bar = [color_data(:, 1), color_data(:, 4)];

[x, y, z] = integrate_three_colors(illuminance_data, reflection_data, x_bar, y_bar, z_bar);
