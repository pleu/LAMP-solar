function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
pitch = 1000;

lattice = [1 0; 1/2 sqrt(3)/2];

%lattice = [1 0; 0 1];
number = [inf inf];

diameter = 600;
wavelength = 550;

st = CircularHoleArray.create_array(pitch, lattice, number, diameter);
%st = CircularHoleArray(pitch, lattice, number, diameter);
%st = CircularHoleArray(pitch, number, holeWidth);
%figure(1);
%clf;
dp = st.calc_diffraction_pattern(wavelength);

figure(1);
clf;
dp.contour_normalized_intensity();

%dp.contour_plot();

figure(2);

dp.plot();


end

