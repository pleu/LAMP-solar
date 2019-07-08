%obj = FilmConeHole(1000e-9,400e-9,400e-9,100e-9, 200e-9);
obj = ConeHoleArray.create_withPitch(100e-9,100e-9,300e-9, 2000e-9);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);