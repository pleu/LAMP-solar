obj = WoodpileNanowire(1000e-9, 2000e-9, 2);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);