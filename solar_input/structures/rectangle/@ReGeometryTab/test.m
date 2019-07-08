go = ReGeometryTab;
go.xMin = -3e-6;
go.xMax = 3e-6;
assert(go.x==0)
assert(go.xSpan==6e-6)

go.yMin = -5e-6;
go.ySpan = 10e-6;
assert(go.yMax == 5e-6); 

go.zSpan = 2.33e-6;

go.write_lsf('test');
