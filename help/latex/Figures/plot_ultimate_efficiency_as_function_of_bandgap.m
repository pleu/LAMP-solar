%PLOT_LIMITING_EFFICIENCY_AS_FUNCTION_OF_BANDGAP
% Plots limiting efficiency as function of band gap.
% Limiting efficiency includes effects of radiative recombination.
% 
% See also PLOT_ULTIMATE_EFFICIENCY_AS_FUNCTION_OF_BANDGAP
% 
% Copyright 2011
% Paul W. Leu
clear;

ss = SolarSpectrum.global_AM1p5;
figure(1);
clf;
[ultimateEfficiency] = ss.plot_ultimate_efficiency_versus_energy;

axis([0 4 0 0.5]);