


% obj = OpticalFilter.create(50e-9,100e-9,sqrt(3)*100e-9, 80e-9);
obj = NanoholeOpticalFilter(50e-9,100e-9,sqrt(3)*100e-9, 40e-9);
obj.Film.OpticalMaterial = 'Al (Aluminium) - CRC';
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);