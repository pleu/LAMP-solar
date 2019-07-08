obj = TruncatedConeHole('Etch', 100e-9, 200e-9, 100e-9);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);