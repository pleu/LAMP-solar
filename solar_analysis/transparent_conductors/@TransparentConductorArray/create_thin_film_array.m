function [tcArray] = create_thin_film_array(...
    solarSpectrum, variableArray, material, independentVariableType)  
% This creates things with FDTD
  pitch = 1*ones(variableArray.NumValues, 1);
  width = pitch;
  
  ra = Rectangle.create_array(variableArray.get_variable_values('t'),...
    width);
  transparentConductors = TransparentConductor.empty(variableArray.NumValues, 0);     
  for i = 1:variableArray.NumValues
    sr = FDTD1D(variableArray.Filenames{i}, independentVariableType, pitch(i), ra{i});
    transparentConductors(i) = TransparentConductor(solarSpectrum, sr, material);
  end
  tcArray = TransparentConductorArray(transparentConductors, variableArray);
end
