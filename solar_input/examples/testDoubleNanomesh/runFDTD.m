%function runFDTD(rtop, rbot, a, T, H)
function runFDTD(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, rTop, rBottom)

P = xSpan; % defien xSpan as the pitch

fid = fopen(create_lsf_filename('runFDTD'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');

SimulationModel = Model(DoubleNanomesh.create(topFilmzSpan, bottomFilmzSpan, activeFilmzSpan, xSpan, rTop, rBottom), ...
    PlaneSource, FrequencyDomainFieldPower, FrequencyDomainFieldPower, FrequencyDomainFieldPower, RefractiveIndex, FDTD);

% filmConeHole = SimulationModel.Structures;
% filmConeHole.FilmMaterial = 'Al (Aluminium) - CRC';
% filmConeHole.ConeMaterial = 'etch';

doubleNanomesh = SimulationModel.Structures;
doubleNanomesh.TopFilmMaterial = 'Al (Aluminium) - CRC';
doubleNanomesh.BottomFilmMaterial = 'Au (Gold) - CRC';
doubleNanomesh.ConeMaterial = 'etch';


% ReSpan = 18e-6;

Source = SimulationModel.Source;
geo = Source.Geometry;
geo.InjectionAxis = 3;
geo.XMin = -P/2;
geo.XMax = P/2;
geo.YSpan = sqrt(3) * P;
geo.Z = topFilmzSpan + activeFilmzSpan/2 + geo.OffSet;

Source.General.Direction = 'Backward';
Source.FrequencyWavelength.WavelengthMin = 0.2e-6;
Source.FrequencyWavelength.WavelengthMax = 1.1e-6;
%Source.write_lsf('runFDTD');

SimulationCell = SimulationModel.SimulationCell;
SimulationCell.MeshSettings.MeshType = 'auto non-uniform';
SimulationCell.MeshSettings.MeshSettings.MeshAccuracy = 2;
% SimulationCell.MeshSettings.MeshSettings = AutoNonUniform('4', 2e-8);
geo = SimulationCell.Geometry;
geo.XSpan = P;
geo.YSpan = sqrt(3) * P;
geo.ZMin = -bottomFilmzSpan - activeFilmzSpan/2 - geo.OffSet;
geo.ZMax = topFilmzSpan + activeFilmzSpan/2 + geo.OffSet;
%geo.ZSpan = L + geo.OffSet;

BC = SimulationCell.BoundaryConditions;
BC.XMinBc = 'Anti-Symmetric';
BC.XMaxBc = 'Anti-Symmetric';
BC.YMinBc = 'Symmetric';
BC.YMaxBc = 'Symmetric';
BC.ZMinBc = 'PML';
BC.ZMaxBc = 'PML';
%SimulationCell.write_lsf('runFDTD');

%ReflectionOffSet = 2e-7;
reflection = SimulationModel.Monitor1;
geo = reflection.Geometry;
reflection.General.OverrideGlobalMonitorSettings = 1;
reflection.General.FrequencyPoints = 200;
geo.XSpan = P;
geo.YSpan = sqrt(3) * P;
geo.Z = topFilmzSpan + activeFilmzSpan/2 + geo.OffSet;
%reflction.write_lsf('runFDTD');

%TransmissionOffSet = 2e-7;
transmission = SimulationModel.Monitor2;
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 200;
geo = transmission.Geometry;
geo.XSpan = P;
geo.YSpan = sqrt(3) * P;
geo.Z = -bottomFilmzSpan - activeFilmzSpan/2 - geo.OffSet;


% 3D field power monitor
field = SimulationModel.Monitor3;
field.General.OverrideGlobalMonitorSettings = 1;
field.General.SimulationType = 3; % 3D monitor
field.General.FrequencyPoints = 200;
geo = field.Geometry;
geo.MonitorType = '3D'; % 3D monitor
geo.XSpan = P;
geo.YSpan = sqrt(3) * P;
geo.ZSpan = activeFilmzSpan;
geo.X = 0;
geo.Y = 0;
geo.Z = 0;

% 3D refractive index monitor 
index = SimulationModel.Monitor4;
index.General.OverrideGlobalMonitorSettings = 1;
field.General.SimulationType = 3; % 3D monitor
index.General.FrequencyPoints = 200;
geo = index.Geometry;
geo.MonitorType = '3D'; % 3D monitor
geo.XSpan = P;
geo.YSpan = sqrt(3) * P;
geo.ZSpan = activeFilmzSpan;
geo.X = 0;
geo.Y = 0;
geo.Z = 0;



%transmission.write_lsf('runFDTD');
SimulationModel.write_lsf('runFDTD');

fclose(fid);


savescript('runFDTD');




