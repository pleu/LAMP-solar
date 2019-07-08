function [tcArray] = create_rectangle_array(solarSpectrum,...
  variableArray, material, independentVariableType)

  ra = Rectangle.create_array(variableArray.get_variable_values('l'),...
    variableArray.get_variable_values('w'));
  pitch = variableArray.get_variable_values('p');
  transparentConductors = TransparentConductor.empty(variableArray.NumValues, 0);     
  for i = 1:variableArray.NumValues
    sr = FDTD1D(variableArray.Filenames{i}, independentVariableType, pitch(i), ra{i});
    transparentConductors(i) = TransparentConductor(solarSpectrum, sr, material);
  end
  tcArray = TransparentConductorArray(transparentConductors, variableArray);
end


