function plot_results_versus_energy(sr, figureNumber)
%PLOT_RESULTS_VERSUS_ENERGY
% Plots reflection, transmission, and absorption results as a function of 
% photon energy
% 
% Copyright 2011
% Paul W. Leu
  if nargin == 1
    figureNumber = 0;
  end
  figure(1 + figureNumber);
  clf;
  sr.ReflectionResults.plot_versus_energy;

  figure(2 + figureNumber);
  clf;
  sr.TransmissionResults.plot_versus_energy;

end
