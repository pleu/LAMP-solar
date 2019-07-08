function plot_energy_versus_wavevector(obj, color)
% PLOT_Energy_VERSUS_WAVEVECTOR
% Plots energy versus wave vector
% 
% See also PLOT_VERSUS_ENERGY
%
%% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh
  energy=obj.Frequency*Constants.LightConstants.C*Constants.LightConstants.H/Constants.LightConstants.a;
  scatter = plot(obj.WaveVector,energy, [color, 'o']);
  set(scatter, 'MarkerSize', 2);
  hold on;
  k_parallel_energy=obj.K_Parallel*Constants.LightConstants.C*Constants.LightConstants.H/Constants.LightConstants.a;
  plot(obj.WaveVector,k_parallel_energy);
  xlabel('Wave Vector');
  ylabel('Energy (eV)');
  grid on;
  axis([0 max(obj.WaveVector) 0 max(max(energy))]);
end