function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here

pitch = 1400;
%lattice = 50*[1 0;0 1];
number = [100];
%number = inf;
holeWidth = 1000;

wavelength = 550;

%st = CircularHoleArray(lattice, number, diameter);

st = OneDSlitArray(pitch, number, holeWidth);
%figure(1);
%clf;
dp = st.calc_diffraction_pattern(wavelength);

figure(1);
clf;
dp.plot();


figure(2);
plot(dp.Kx, dp.NormalizedIntensity);
% can use variable k_x a/2 like in Hecht
% or use lambda/a
% sin theta = q/z

% find(dp.NormalizedIntensity ~=0);
% 
% ind = find(dp.Kx == 0);
% around = 4;
% dp.NormalizedIntensity(ind-around:ind+around);
% indices = ind-around:ind+around;
% trapz(dp.Kx(indices), dp.NormalizedIntensity(indices))



end

