function [x, fval, exitFlag] = geneticSolarTest()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the thin film

gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.9,'Generations',50,'MutationFcn',{@mutationadaptfeasible,0.01},...
    'PopulationSize',10,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionuniform,'StallGenLimit',5,...
    'TolFun', 1e-10, 'Vectorized','off', 'Display', 'diagnose');
% gaoptions=gaoptimset('CreationFcn',@gacreationlinearfeasible,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',20,...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'TolFun', 1e-10,'Vectorized','off');

%[x,fval,exitFlag]=ga(@(x)objFnc(rtop, rbot, H, a, T),5,[],[],[],[],[],[],...
%    [],gaoptions);


ConeHeight = 50*Constants.UnitConversions.NMtoM; % nm
maxPitch = 1000*Constants.UnitConversions.NMtoM;
 
% constraints are
% 2*rtop < a; 
% 2*rbot < a
% a < maxPitch

%x=[rtop, rbot, a, T]
A = [2 -1]; 
b = 0; 

lowerBound = [0; 0];           %lower bound, T > ET
upperBound = [0; maxPitch];           %lower bound, T > ET

%ub = []*nmTom;

nVariables = size(A, 2);

[x,fval,exitFlag]=ga(@(x)objFnc(x, ConeHeight),nVariables,A,b,[],[],lowerBound,upperBound,[], gaoptions);


% define creation function
function pop = createFcn(NVARS,~,options)
  pop = load('firstgeneration.txt');

function UE = objFnc(x, ConeHeight)
  rtop = x(1);
  %rbot = x(2);
  a = x(2);
  runFDTD(a, ConeHeight, rtop);

  materialName = 'GaAs';
  load('InputVariables');      % load the InputVariables, so we can use the filename
  sr = FDTDSimulationResults(filename);
  ma = MaterialType.create(materialName);
  SS = SolarSpectrum.global_AM1p5();
  sc = SolarCell(SS, sr, ma);
  UE = sc.UltimateEfficiency;
  UE = -UE;                        %the GA algorithm gives out the minimum value, so we negative UE



