obj = RectangleFDTD();
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end

obj.OpticalMaterial = 'Si (Silicon)';
obj.write_lsf(filename);
