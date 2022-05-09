function [scArray] = create(solarSpectrum, sr, variableArray, material)
    % sr is an array of FDTDSimulations
  solarCells = SolarCell.empty(variableArray.NumValues, 0);     
  for i = 1:variableArray.NumValues
    %sr = FDTDSimulationResults(variableArray.Filenames{i}, independentVariableType);
    
    solarCells(i) = SolarCell(solarSpectrum, sr(i), material);
    if strcmpi(variableArray.Names, 'theta')
      %keyboard;
      solarCells(i).adjust_for_theta(variableArray.Values(i));
    end
  end  
  scArray = SolarCellArray(solarCells, variableArray);
end

