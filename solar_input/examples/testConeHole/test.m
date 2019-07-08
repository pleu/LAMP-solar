%function UE = test(rtop, rbot, H, a, T);
function [UE, EquivalentT] = test(varargin)
%function test(varargin)
fid = fopen(create_lsf_filename('test'), 'w+');
fprintf(fid, 'selectall; \n');
fprintf(fid, 'delete; \n');

fprintf(fid, 'rTopValue = 0.1e-6; \n');
fprintf(fid, 'rBottomValue = 0.2e-6; \n');
fprintf(fid, 'zSpanValue = 0.5e-6; \n');
Hole = TruncatedConeHole();
%Hole = FilmConeHole();
property = Hole.Properties;
property.rTopValue = 0.01e-6;  % in micron
property.rBottomValue = 0.02e-6; % in micron
property.zSpanValue = 0.5e-6; % in micron
property.z = 0.25e-6;
Hole.write_lsf('test');

Re = RectangleFDTD();
Re.Material.OpticalMaterial = 'Si (Silicon)';
go = Re.Geometry;
%go.xMin = -1e-6;
go.xSpan = 1e-6;
%go.yMin = -1e-6;
go.ySpan = 1e-6;
go.zSpan = 1e-6;
%go.z = -0.3e-6;
%go.zMax = 0.5e-6;
Re.write_lsf('test');

Source = PlaneSource();
go = Source.Geometry;
go.XMin = -3e-6;
go.XMax = 3e-6;
go.YSpan = 6e-6;
go.Z = 0.7e-6;
Source.General.Direction = 'Backward';
Source.FrequencyWavelength.WavelengthMin = 0.4e-6;
Source.FrequencyWavelength.WavelengthMax = 2e-6;
Source.write_lsf('test');

SimulationCell = FDTD();
go = SimulationCell.Geometry;
go.XSpan = 0.1e-6;
%go.XMax = 0.2e-6;
go.YSpan = 0.1e-6;
go.YMin = -0.05e-6;
go.ZSpan = 2.2e-6;
SimulationCell.write_lsf('test');

reflction = FrequencyDomainFieldPower();
go = reflction.Geometry;
reflction.General.OverrideGlobalMonitorSettings = 1;
reflction.General.FrequencyPoints = 1000;
go.XSpan = 1e-6;
go.YSpan = 1e-6;
go.Z = 0.9e-6;
reflction.write_lsf('test');

transmission = FrequencyDomainFieldPower();
transmission.General.OverrideGlobalMonitorSettings = 1;
transmission.General.FrequencyPoints = 1000;
go = transmission.Geometry;
go.XSpan = 1e-6;
go.YSpan = 1e-6;
go.Z = -0.7e-6;
transmission.write_lsf('test');

fclose(fid);


fid = fopen(create_lsf_filename('test'), 'a+');
fprintf(fid, 'save("test1"); \n');
fprintf(fid, 'run; \n');
fprintf(fid, 'frequencyTransmission = getdata("monitor_1","f"); \n');
fprintf(fid, 'transmissionData = -transmission("monitor_1"); \n');
fprintf(fid,'dataTransmission = [transpose(frequencyTransmission); transpose(transmissionData)]; \n');
fprintf(fid,'write("ThinFilmHole"+"Transmission.txt",num2str(dataTransmission));\n');
fprintf(fid,'reflectionData = transmission("monitor"); \n');
fprintf(fid,'dataReflection = [transpose(frequencyTransmission); transpose(reflectionData)]; \n');
fprintf(fid,'write("ThinFilmHole"+"Reflection.txt",num2str(dataReflection)); \n');
fprintf(fid,' \n');
fprintf(fid,'exit; \n');
system(('"C:\Program Files\Lumerical\FDTD\bin\fdtd-solutions.exe" -run test.lsf'));
materialName = 'Si';
filename = 'ThinFilmHole';
sr = FDTDSimulationResults(filename);
ma = MaterialType.create(materialName);
% figure(1);
% clf;
% sr.plot_results_versus_wavelength;
%axis([400 2000 0 1]);
SS = SolarSpectrum.global_AM1p5();
sc = SolarCell(SS, sr, ma);
UE = sc.UltimateEfficiency;

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
EquivalentT = (Re.Geometry.Volume - Hole.Properties.Volume)/Re.Geometry.Area;


