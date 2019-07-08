function runFDTD(effectiveThickness, T, a, rtop, rbot)

fid = fopen(create_lsf_filename('runFDTD'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');

simulationModel = Model(FilmConeHoleTop.create_withEquivalentThickness(effectiveThickness, T, a, rtop, rbot), PlaneSource, FrequencyDomainFieldPower, FrequencyDomainFieldPower, FDTD);

filmConeHole = simulationModel.Structures;
filmConeHole.FilmMaterial = 'Si (Silicon)';
filmConeHole.ConeMaterial = 'etch';

ReSpan = 18e-6;
Source = simulationModel.Source;
geo = Source.Geometry;
geo.InjectionAxis = 3;
geo.XMin = -ReSpan/2;
geo.XMax = ReSpan/2;
geo.YSpan = ReSpan;
geo.Z = T/2 + geo.OffSet;

Source.General.Direction = 'Backward';
Source.FrequencyWavelength.WavelengthMin = 0.28e-6;
Source.FrequencyWavelength.WavelengthMax = 2e-6;
%Source.write_lsf('runFDTD');

SimulationCell = simulationModel.SimulationCell;
% SimulationCell.MeshSettings.MeshType = 'auto non-uniform';
% SimulationCell.MeshSettings.MeshSettings.MeshAccuracy = 2;
%SimulationCell.MeshSettings.MeshSettings = AutoNonUniform(3, 2e-8);
geo = SimulationCell.Geometry;
geo.XSpan = a;
geo.YSpan = a;
geo.ZSpan = T + 2*geo.OffSet;

BC = SimulationCell.BoundaryConditions;
BC.XMinBc = 'Anti-Symmetric';
BC.XMaxBc = 'Anti-Symmetric';
BC.YMinBc = 'Symmetric';
BC.YMaxBc = 'Symmetric';
%SimulationCell.write_lsf('runFDTD');

%ReflectionOffSet = 2e-7;
reflction = simulationModel.Monitor1;
geo = reflction.Geometry;
reflction.General.OverrideGlobalMonitorSettings = 1;
reflction.General.FrequencyPoints = 1000;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = T/2 + geo.OffSet;
%reflction.write_lsf('runFDTD');

%TransmissionOffSet = 2e-7;
transmission = simulationModel.Monitor2;
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 1000;
geo = transmission.Geometry;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = -T/2 - geo.OffSet;
%transmission.write_lsf('runFDTD');
simulationModel.write_lsf('runFDTD');

fclose(fid);

% fid = fopen(create_lsf_filename('runFDTD'), 'a+');
% fprintf(fid, 'filename = "rtop"+num2str(rtop*1e9)+"rbot"+num2str(rbot*1e9)+"a"+num2str(a*1e9)+"T"+num2str(T*1e9) ;\n');
% fclose(fid);
savescript('runFDTD');
if ispc 
  system(('"C:\Program Files\Lumerical\FDTD\bin\fdtd-solutions.exe" -run runFDTD.lsf'));
elseif isunix
  system(
end
  




