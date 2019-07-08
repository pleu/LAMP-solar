function plot_frequency_versus_wavevector(sr)
%PLOT_FREQUENCY_VERSUS_WAVEVECTOR
% Plot TE and TM as scatter in the unit of normalized frequency
% 
% Copyright 2011
% Baomin Wang
  sr.TEResults.plot_frequency_versus_wavevector('b');
  hold on;
  sr.TMResults.plot_frequency_versus_wavevector('r');
end
  
