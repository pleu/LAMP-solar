function [tcArray] = create_nano_mesh_array(solarSpectrum,...
  variableArray, material, independentVariableType)

  ca = Mesh.create_array(variableArray.get_variable_values('t'),variableArray.get_variable_values('d'));
  pitch = variableArray.get_variable_values('p');
  transparentConductors = TransparentConductor.empty(variableArray.NumValues, 0);     
  for i = 1:variableArray.NumValues
    sr = Nanomesh.create_array(variableArray.Filenames(i, :), independentVariableType, pitch(i), ca{i});
%    sr = FDTD1D(variableArray.Filenames{i}, independentVariableType, pitch(i), ca{i});
    transparentConductors(i) = TransparentConductor(solarSpectrum, sr, material);
  end
  tcArray = TransparentConductorArray(transparentConductors, variableArray);
end


