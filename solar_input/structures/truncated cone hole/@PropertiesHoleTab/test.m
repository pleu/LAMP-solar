obj = PropertiesHoleTab();
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);