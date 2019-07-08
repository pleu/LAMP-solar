function display_ultimate_efficiency(sr)
%DISPLAY_ULTIMATE_EFFICIENCY
% Displays the ultimate efficiency
% 
%% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh
  for iSimulation = 1:sr.NumSimulations
    disp(['Filename: ', sr.FDTDSimulationArray(iSimulation).Filename]);
    disp(['Ultimate Efficiency: ',...
      num2str(sr.FDTDSimulationArray(iSimulation).UltimateEfficiency)]);
  end
end
