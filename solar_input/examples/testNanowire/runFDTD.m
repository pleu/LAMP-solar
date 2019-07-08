%function runFDTD(rtop, rbot, a, T, H)
function runFDTD(a, ConeHeight, rtop)

P = a;

fid = fopen(create_lsf_filename('runFDTD'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');

SimulationModel = Model(Nanocone.create_withConeHeight(ConeHeight, rtop), PlaneSource, FrequencyDomainFieldPower, FrequencyDomainFieldPower, FDTD);

coneArray = SimulationModel.Structures;
coneArray.ConeMaterial = 'GaAs - Palik';


ReSpan = 18e-6;
OffSet = ConeHeight;
Source = SimulationModel.Source;
geo = Source.Geometry;
geo.InjectionAxis = 3;
geo.XMin = -ReSpan/2;
geo.XMax = ReSpan/2;
geo.YSpan = ReSpan;
geo.Z = ConeHeight/2 + OffSet;

Source.General.Direction = 'Backward';
Source.FrequencyWavelength.WavelengthMin = 0.28e-6;
Source.FrequencyWavelength.WavelengthMax = 2e-6;
%Source.write_lsf('runFDTD');

SimulationCell = SimulationModel.SimulationCell;
% SimulationCell.MeshSettings.MeshType = 'auto non-uniform';
% SimulationCell.MeshSettings.MeshSettings.MeshAccuracy = 2;
%SimulationCell.MeshSettings.MeshSettings = AutoNonUniform(3, 2e-8);
geo = SimulationCell.Geometry;
geo.XSpan = P;
geo.YSpan = P;
geo.ZMin = -ConeHeight/2 - 2*OffSet;
geo.ZMax = ConeHeight/2 + 3*OffSet;
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
reflction = SimulationModel.Monitor1;
geo = reflction.Geometry;
reflction.General.OverrideGlobalMonitorSettings = 1;
reflction.General.FrequencyPoints = 1000;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = ConeHeight/2 + 2*OffSet;
%reflction.write_lsf('runFDTD');

%TransmissionOffSet = 2e-7;
transmission = SimulationModel.Monitor2;
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 1000;
geo = transmission.Geometry;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = -ConeHeight/2 - OffSet;
%transmission.write_lsf('runFDTD');
SimulationModel.write_lsf('runFDTD');

fclose(fid);

fid = fopen(create_lsf_filename('runFDTD'), 'a+');
fprintf(fid, ['filename = ','"rtop' num2str(rtop*1e9), 'rbot' num2str(rtop*1e9), 'a" +num2str(', num2str(a*1e9), ')' '; \n']);  
fclose(fid);
savescript('runFDTD');




