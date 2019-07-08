obj = PropertiesTab(500e-9, 2000e-9, 2);
%obj.Material = 'Si';
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);