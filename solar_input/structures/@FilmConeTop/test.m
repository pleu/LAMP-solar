%obj = FilmConeHole(1000e-9,400e-9,400e-9,100e-9, 200e-9);
obj = FilmConeTop.create_withEquivalentThickness(1000e-9,800e-9,400e-9,100e-9,200e-9);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);