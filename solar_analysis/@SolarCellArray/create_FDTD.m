function [scArray] = create_FDTD(solarSpectrum,...
      variableArray, material, independentVariableType)
%CREATE
% 
% CREATE(solarSpectrum,...
%      variableArray, material, independentVariableType)
% This assumes FDTDSimulationResults are used
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh
  if nargin == 3
    independentVariableType = 'Frequency';
  end
  %  sr = FDTDSimulationResultsArray.create(variableArray, independentVariableType);
  %solarCells = SolarCell.empty(variableArray.NumValues, 0);
  
  sra = FDTDSimulationResultsArray.create(variableArray, independentVariableType);
  scArray = SolarCellArray.create(solarSpectrum, sra.Simulations, variableArray, material);
  
end

