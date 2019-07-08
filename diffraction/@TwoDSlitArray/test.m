function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here

pitch = 50;
lattice = [1 0; 0 1];
%lattice = 50*[1 0; 1/2 sqrt(3)/2];

number = [inf inf];
holeWidth = [20; 20];

wavelength = [20];

st = TwoDSlitArray(pitch, lattice, number, holeWidth);
dp = st.calc_diffraction_pattern(wavelength);

%dp.contour_plot()
figure(1);
clf;
dp.contour_normalized_intensity();

%dp.contour_plot();



end

