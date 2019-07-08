function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
%pitch = 500;
diameter = 800;
wavelength = 500;

st = CircularHole(diameter);
dp = st.calc_diffraction_pattern(wavelength);
figure(1);
clf;
%dp.contour_plot();


dp.contour_normalized_intensity();

%st.plot_diffraction_pattern(wavelength);


figure(1);
clf;
dp.plot();

% can use variable k_x a/2 like in Hecht
% or use lambda/a
% sin theta = q/z


end

