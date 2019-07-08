function sr = create_array(filename, independentVariableType, pitch, shape)
  sr = FDTD1D.empty(size(filename, 1), 0);
  for i = 1:size(filename, 2)
    sr(i) = FDTD1D(filename{i}, independentVariableType, pitch, shape);
  end
end

