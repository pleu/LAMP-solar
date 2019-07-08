function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
%pitch = 500;
holeWidth = [40];
wavelength = 20;

st = OneDSlit(holeWidth);
dp = st.calc_diffraction_pattern(wavelength);
figure(1);
clf;
dp.plot();


end

