function [] = test()

holeWidth = [800; 800];
%holeWidthY = 40;

wavelength = 500;

% figure(1);
% clf;

%theta = 0:10:90;
st = TwoDSlit(holeWidth);
%assert(st.HoleWidth == 10);
dp = st.calc_diffraction_pattern(wavelength);

figure(1);
clf;

dp.contour_normalized_intensity();

figure(1);
clf;
dp.plot
% dp2 = st.calc_diffraction_pattern(wavelength);
% dp2.contour_plot();
%.plot('X', 0);

% dp2 = st.calc_diffraction_pattern2(wavelength);
% dp2.contour_plot2();

%figure(4);
%dp.contour_plot_polar();

% figure(1);
% clf;
% dp.plot();


end

