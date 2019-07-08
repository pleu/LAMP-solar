function [scArray] = simulate(scArray)
% SIMULATE
% 
% Simulate the array of solar cells
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

  for i = 1:scArray.NumSolarCell
    scArray.SolarCell(i) = scArray.SolarCell(i).runSQSimulation;
  end
end

