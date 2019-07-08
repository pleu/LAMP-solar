%obj = FilmConeHole(1000e-9,400e-9,400e-9,100e-9, 200e-9);
obj = FilmConeHoleBoth.create_withEquivalentThickness(9.1976e-7, 1000e-9, 1300e-9, 500e-9, 400e-9, 100e-9, 250e-9, 150e-9);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);