go = GeometryFDTDTab;
go.XMin = -3e-6;
go.XMax = 3e-6;
assert(go.X==0)
assert(go.XSpan==6e-6)

go.YSpan = 10e-6;
go.YMin = -5e-6;
assert(go.YMax == 5e-6); 
go.write_lsf('test');