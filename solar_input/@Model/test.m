obj = Model(FilmConeHole, PlaneSource, FrequencyDomainFieldPower, FrequencyDomainFieldPower, FDTD);
filename = 'test.lsf';
if exist(filename, 'file')
  delete(filename)
end
obj.write_lsf(filename);

% thickness = 1000e-6; % 
% 
% hole = TruncatedConeHole();
% %Hole = FilmConeHole();
% property = hole.Properties;
% property.rTopValue = rtop;  % in micron
% property.rBottomValue = rbot; % in micron
% property.zSpanValue = height; % in micron
% property.z = thickness/2 - height/2;
% %fprintf(fid, 'set("z", T/2 - H/2); \n');
% %Hole.write_lsf('runFDTD');
% 
% Respan = 10e-6; %any large value
% Re = RectangleFDTD();
% Re.Material.OpticalMaterial = 'Si (Silicon)';
% go = Re.Geometry;
% %go.xMin = -1e-6;
% go.xSpan = Respan;
% %go.yMin = -1e-6;
% go.ySpan = Respan;
% go.zSpan = thickness;
% %fprintf(fid, 'set("z", T);\n');
% %go.z = -0.3e-6;
% %go.zMax = 0.5e-6;
% %Re.write_lsf('runFDTD');
% 
% 
% 
% sourcespan = 18e-6;  % width of source in m; 
% sourceOffSet = 1e-7; % offset from top of structure in m
% 
% source = PlaneSource();
% go = Source.Geometry;
% go.InjectionAxis = 3; % in z-direction
% go.XMin = -Sourcespan/2;
% go.XMax = Sourcespan/2;
% go.YSpan = Sourcespan;
% go.Z = thickness/2 + SourceOffSet;
% 
% 
% 
% obj = Model();
% obj.write_lsf('test');