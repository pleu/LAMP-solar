function [scArray] = create(solarSpectrum,...
      variableArray, structureArray, material, thetaE, internalFluorescence)
%CREATE
% 
% CREATE(solarSpectrum,...
%      variableArray, material, independentVariableType)
% 
% Copyright 2012
% Paul W. Leu 
% LAMP, University of Pittsburgh
  scArray = DetailedSolarCell.empty(length(structureArray), 0);
  if nargin == 4
    for i = 1:variableArray.NumValues
      scArray(i) = ...
        DetailedSolarCell(solarSpectrum, structureArray(i), material);
    end
  elseif nargin == 5
    for i = 1:variableArray.NumValues
      scArray(i) = ...
        DetailedSolarCell(solarSpectrum, structureArray(i), material, thetaE);
    end
  elseif nargin == 6
    for i = 1:variableArray.NumValues
      scArray(i) = ...
        DetailedSolarCell(solarSpectrum, structureArray(i), material, thetaE,...
        internalFluorescence);
    end
  end
  scArray = DetailedSolarCellArray(scArray, variableArray);  
end

