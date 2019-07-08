function plot_frequency_versus_wavevector(obj, color)
% PLOT_FREQUENCY_VERSUS_WAVEVECTOR
% Plots normalized frequency versus wave vector
% 
% See also PLOT_VERSUS_ENERGY
%
%% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh
  scatter = plot(obj.WaveVector,obj.Frequency, [color, 'o']);
  set(scatter, 'MarkerSize', 2);
  hold on;
  plot(obj.WaveVector,obj.K_Parallel);
  xlabel('Wave Vector');
  ylabel('Normalized Frequency (f*a/c)');
  grid on;
  axis([0 max(obj.WaveVector) 0 1]);
end
