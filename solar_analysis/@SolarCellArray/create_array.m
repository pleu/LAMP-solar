function [scArray] = create_array(solarSpectrum,...
      variableArray, material, independentVariableType)
    
  solarCells = TransparentConductor.empty(variableArray.NumValues, 0);     
  for i = 1:variableArray.NumValues
    sr = FDTDSimultionResults(variableArray.Filenames{i}, independentVariableType);
    solarCells(i) = TransparentConductor(solarSpectrum, sr, material);
  end
  scArray = SolarCellArray(solarCells, variableArray);
end

