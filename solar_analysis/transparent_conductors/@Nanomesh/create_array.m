function sr = create_array(filename, independentVariableType, pitch, shape)
  sr = Nanomesh.empty(size(filename, 1), 0);
  for i = 1:size(filename, 2)
    sr(i) = Nanomesh(filename{i}, independentVariableType, pitch, shape);
  end
end

