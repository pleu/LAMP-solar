%function runFDTD(rtop, rbot, a, T, H)
function runFDTD()
%   if nargin == 0
%     rtop = 0;
%     rbot = 0;
%     a = 0;
%     T = 0;
%     H = 0;
%   end
load('Input.txt');
rtop = Input(1);
rbot = Input(2);
P = Input(3);  % pitch
L = Input(4);  % thickness of thin film
Height = Input(5); % height of the nano hole
%function test(varargin)
fid = fopen(create_lsf_filename('runFDTD'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');

% fprintf(fid, 'rTopValue = 0.1e-6; \n');
% fprintf(fid, 'rBottomValue = 0.2e-6; \n');
% fprintf(fid, 'zSpanValue = 0.5e-6; \n');
fprintf(fid, 'Input = readdata("Input.txt"); \n');
fprintf(fid, 'rtop = Input(1); \n');
fprintf(fid, 'rbot = Input(2); \n');
fprintf(fid, 'a = Input(3); \n');
fprintf(fid, 'T = Input(4); \n');
fprintf(fid, 'H = Input(5); \n');
fprintf(fid, 'rTopValue = rtop; \n');
fprintf(fid, 'rBottomValue = rbot; \n');
fprintf(fid, 'zSpanValue = H; \n');

Hole = TruncatedConeHole();
%Hole = FilmConeHole();
property = Hole.Properties;
property.rTopValue = rtop;  % in micron
property.rBottomValue = rbot; % in micron
property.zSpanValue = Height; % in micron
property.z = L/2 - Height/2;
%fprintf(fid, 'set("z", T/2 - H/2); \n');
Hole.write_lsf('runFDTD');

Respan = 10e-6; %any large value
Re = RectangleFDTD();
Re.Material.OpticalMaterial = 'Si (Silicon)';
go = Re.Geometry;
%go.xMin = -1e-6;
go.xSpan = Respan;
%go.yMin = -1e-6;
go.ySpan = Respan;
go.zSpan = L;
%fprintf(fid, 'set("z", T);\n');
%go.z = -0.3e-6;
%go.zMax = 0.5e-6;
Re.write_lsf('runFDTD');

Sourcespan = 18e-6;
SourceOffSet = 1e-7;
Source = PlaneSource();
go = Source.Geometry;
%go.XSpan = Sourcespan;
go.InjectionAxis = 3;
go.XMin = -Sourcespan/2;
go.XMax = Sourcespan/2;
go.YSpan = Sourcespan;
go.Z = L/2 + SourceOffSet;

Source.General.Direction = 'Backward';
Source.FrequencyWavelength.WavelengthMin = 0.28e-6;
Source.FrequencyWavelength.WavelengthMax = 2e-6;
Source.write_lsf('runFDTD');

FDTDOffSet = 6e-7;
SimulationCell = FDTD();
% SimulationCell.MeshSettings.MeshType = 'auto non-uniform';
% SimulationCell.MeshSettings.MeshSettings.MeshAccuracy = 2;
%SimulationCell.MeshSettings.MeshSettings = AutoNonUniform(3, 2e-8);
go = SimulationCell.Geometry;
go.XSpan = P;
%go.XMax = 0.2e-6;
go.YSpan = P;
%go.YMin = -0.05e-6;
go.ZSpan = L + FDTDOffSet;
BC = SimulationCell.BoundaryConditions;
BC.XMinBc = 'Anti-Symmetric';
BC.XMaxBc = 'Anti-Symmetric';
BC.YMinBc = 'Symmetric';
BC.YMaxBc = 'Symmetric';
SimulationCell.write_lsf('runFDTD');

ReflectionOffSet = 2e-7;
reflction = FrequencyDomainFieldPower();
go = reflction.Geometry;
reflction.General.OverrideGlobalMonitorSettings = 1;
reflction.General.FrequencyPoints = 1000;
go.XSpan = Sourcespan;
go.YSpan = Sourcespan;
go.Z = L/2 + ReflectionOffSet;
reflction.write_lsf('runFDTD');

TransmissionOffSet = 2e-7;
transmission = FrequencyDomainFieldPower();
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 1000;
go = transmission.Geometry;
go.XSpan = Sourcespan;
go.YSpan = Sourcespan;
go.Z = -L/2 - TransmissionOffSet;
transmission.write_lsf('runFDTD');

fclose(fid);


fid = fopen(create_lsf_filename('runFDTD'), 'a+');
fprintf(fid, 'filename = "rtop"+num2str(rtop*1e9)+"rbot"+num2str(rbot*1e9)+"a"+num2str(a*1e9)+"T"+num2str(T*1e9) ;\n');
fprintf(fid, 'save("runFDTD"); \n');
fprintf(fid, 'if (fileexists(filename+"Reflection.txt")) { \n matlabsave("InputVariables",filename); \n exit; \n } \n');
fprintf(fid, 'else { \n run; \n } \n');
%fprintf(fid, 'run; \n');
fprintf(fid, 'frequencyTransmission = getdata("monitor_1","f"); \n');
fprintf(fid, 'transmissionData = -transmission("monitor_1"); \n');
fprintf(fid,'dataTransmission = [transpose(frequencyTransmission); transpose(transmissionData)]; \n');
%fprintf(fid,'write("ThinFilmHole"+"Transmission.txt",num2str(dataTransmission));\n');
fprintf(fid,'write(filename+"Transmission.txt",num2str(dataTransmission));\n');
fprintf(fid,'reflectionData = transmission("monitor"); \n');
fprintf(fid,'dataReflection = [transpose(frequencyTransmission); transpose(reflectionData)]; \n');
%fprintf(fid,'write("ThinFilmHole"+"Reflection.txt",num2str(dataReflection)); \n');
fprintf(fid,'write(filename+"Reflection.txt",num2str(dataReflection)); \n');
fprintf(fid,'matlabsave("InputVariables",filename); \n');
fprintf(fid,'exit; \n');
system(('"C:\Program Files\Lumerical\FDTD\bin\fdtd-solutions.exe" -run runFDTD.lsf'));
% materialName = 'Si';
% %filename = 'ThinFilmHole';
% load('InputVariables');
% sr = FDTDSimulationResults(filename);
% ma = MaterialType.create(materialName);
% % figure(1);
% % clf;
% % sr.plot_results_versus_wavelength;
% %axis([400 2000 0 1]);
% SS = SolarSpectrum.global_AM1p5();
% sc = SolarCell(SS, sr, ma);
% UE = sc.UltimateEfficiency;

% ga = UE
% x = ga(fitnessfcn,nvars,A,b,Aeq,beq,LB,UB)
% 
% %demension of triangle
% T >= 2000e-9; %(2000 is the equivalentT)
% rTop >= 0;
% rTop <= 0.05e-6;  %(should be smaller than the FDTD area)
% rTop >= 0;
% rTop <= 0.05e-6;
% H <= T;
