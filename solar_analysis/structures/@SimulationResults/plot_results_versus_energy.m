function plot_results_versus_energy(sr, figureNumber, varargin)
%PLOT_RESULTS_VERSUS_ENERGY
% Plots reflection, transmission, and absorption results as a function of 
% photon energy
% 
% Copyright 2011
% Paul W. Leu
  color = ('bgrcmy');
  if nargin == 1
    figureNumber = 0;
  end
  figure(1 + figureNumber);
  %clf;
  

  for i = 1:size(sr, 2)
    if nargin > 2
      sr(i).ReflectionResults.plot_versus_energy(varargin{i}{:});
    else
      sr(i).ReflectionResults.plot_versus_energy('Color', color(i));
    end
    
    hold on;
  end

  figure(2 + figureNumber);
  %clf;
  for i = 1:size(sr, 2)
    if nargin > 2
      sr(i).TransmissionResults.plot_versus_energy(varargin{i}{:});
    else
      sr(i).TransmissionResults.plot_versus_energy('Color', color(i));
    end
    hold on;
  end

  figure(3 + figureNumber);
  %clf;
  for i = 1:size(sr, 2)
    if nargin > 2
      sr(i).AbsorptionResults.plot_versus_energy(varargin{i}{:});
    else
      sr(i).AbsorptionResults.plot_versus_energy('Color', color(i));
    end
    hold on;
  end
  
end

