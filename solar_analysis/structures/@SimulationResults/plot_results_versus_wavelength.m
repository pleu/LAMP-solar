function plot_results_versus_wavelength(sr, figureNumber, varargin)
%PLOT_RESULTS_VS_WAVELENGTH
% Plots reflection, transmission, and absorption results as a function of 
% wavelength
% 
% Copyright 2011
% Paul W. Leu
  color = ('bgrcmy');
  if nargin == 1
    figureNumber = 1;
  end
  figure(0 + figureNumber);
  %clf;
  for i = 1:size(sr, 2)
    sr(i).ReflectionResults.plot_versus_wavelength('Color', color(i));
    hold on;
  end

  figure(1 + figureNumber);
  %clf;
  for i = 1:size(sr, 2)
    sr(i).TransmissionResults.plot_versus_wavelength('Color', color(i));
    hold on;
  end
  
  figure(2 + figureNumber);
  %clf;
  for i = 1:size(sr, 2)
    sr(i).AbsorptionResults.plot_versus_wavelength('Color', color(i));
    hold on;
  end
end

