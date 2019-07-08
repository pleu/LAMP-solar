function [] = test2()
%TEST Summary of this function goes here
%   Detailed explanation goes here
pitch = [400 450 500];
lattice = [1 0; 0 1];
number = [inf inf];

diameter = [300 350];
wavelength = 20;

st = CircularHoleArray(pitch, lattice, number, diameter);
%st = CircularHoleArray(pitch, number, holeWidth);
%figure(1);
%clf;
dp = st.calc_diffraction_pattern(wavelength);

% figure(1);
% clf;
% dp.contour_plot();
% 
% figure(2);
% 
% dp.plot();


end


