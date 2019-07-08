function [scArray] = simulate_all(scArray)
% SIMULATE
% 
% Simulate the array of solar cells
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

  for i = 1:scArray.NumSolarCell
    scArray.SolarCell(i) = scArray.SolarCell(i).runSQSimulation;
    scArray.SolarCell(i).SQSimulation = ...
      scArray.SolarCell(i).SQSimulation.calcDetailedSimulationResults;
  end
end

