%function runFDTD(rtop, rbot, a, T, H)
function runFDTD(EffectiveThickness)

load('Input.txt');
rtop = Input(1);
rbot = rtop;
P = Input(2);  % pitch
L = Input(3);  % thickness of thin film
%Height = Input(5); % height of the nano hole

fid = fopen(create_lsf_filename('runFDTD'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');
%load the input file and define parameters;
fprintf(fid, 'Input = readdata("Input.txt"); \n');
fprintf(fid, 'rtop = Input(1); \n');
fprintf(fid, 'rbot = Input(1); \n');
fprintf(fid, 'a = Input(2); \n');
fprintf(fid, 'T = Input(3); \n');
%fprintf(fid, 'H = Input(5); \n');
fprintf(fid, 'rTopValue = rtop; \n');
fprintf(fid, 'rBottomValue = rbot; \n');
%fprintf(fid, 'zSpanValue = H; \n');

%%%%%%%%%%%%%%%%%%
%Building simulation model
%%%%%%%%%%%%%%%%%%
SimulationModel = Model(FilmCylinder, PlaneSource, FrequencyDomainFieldPower, FrequencyDomainFieldPower, FDTD);

filmCylinder = SimulationModel.Structures;
filmCylinder .EquivalentT = EffectiveThickness;
filmCylinder .Area = P*P;

Respan = 10e-6; %any large value
film = filmCylinder.Film;
film.Material.OpticalMaterial = 'Si (Silicon)';
geo = film.Geometry;
geo.XSpan = Respan;
geo.YSpan = Respan;
geo.ZSpan = L;

Cylinder = filmCylinder.Cone;
property = Cylinder.Properties;
property.MaterialValue = 'Si (Silicon) - Palik';
property.RTopValue = rtop;  % in micron
property.RBottomValue = rbot; % in micron
property.ZSpanValue = filmCylinder.ConeH; % in micron
property.Z = L/2 + filmCylinder.ConeH/2;
%fprintf(fid, 'set("z", T/2 - H/2); \n');
%Hole.write_lsf('runFDTD');

ReSpan = 18e-6;
Source = SimulationModel.Source;
geo = Source.Geometry;
geo.InjectionAxis = 3;
geo.XMin = -ReSpan/2;
geo.XMax = ReSpan/2;
geo.YSpan = ReSpan;
geo.Z = L/2 + geo.OffSet + filmCylinder.ConeH;

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
%geo.ZSpan = L + 2*geo.OffSet;
geo.ZMax = L/2 + geo.OffSet + filmCylinder.ConeH;
geo.ZMin = -L/2 - geo.OffSet;
BC = SimulationCell.BoundaryConditions;
BC.XMinBc = 'Anti-Symmetric';
BC.XMaxBc = 'Anti-Symmetric';
BC.YMinBc = 'Symmetric';
BC.YMaxBc = 'Symmetric';
%SimulationCell.write_lsf('runFDTD');

%ReflectionOffSet = 2e-7;
reflction = SimulationModel.Monitor1;
geo = reflction.Geometry;
reflction.General.OverrideGlobalMonitorSettings = 1;
reflction.General.FrequencyPoints = 1000;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = L/2 + geo.OffSet + filmCylinder.ConeH;
%reflction.write_lsf('runFDTD');

%TransmissionOffSet = 2e-7;
transmission = SimulationModel.Monitor2;
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 1000;
geo = transmission.Geometry;
geo.XSpan = ReSpan;
geo.YSpan = ReSpan;
geo.Z = -L/2 - geo.OffSet;
%transmission.write_lsf('runFDTD');
SimulationModel.write_lsf('runFDTD');

fclose(fid);

fid = fopen(create_lsf_filename('runFDTD'), 'a+');
fprintf(fid, 'filename = "rtop"+num2str(rtop*1e9)+"rbot"+num2str(rbot*1e9)+"a"+num2str(a*1e9)+"T"+num2str(T*1e9) ;\n');
fclose(fid);
savescript('runFDTD');




