function plot_energyresults_versus_wavevector(sr)
%PLOT_ENERGY_VERSUS_WAVEVECTOR
% Plot TE and TM as scatter in the unit of energy
% 
% Copyright 2011
% Baomin Wang
  sr.TEResults.plot_energy_versus_wavevector('b');
  hold on;
  sr.TMResults.plot_energy_versus_wavevector('r');
end