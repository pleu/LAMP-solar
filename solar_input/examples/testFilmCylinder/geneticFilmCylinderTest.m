function [x, fval, exitFlag] = geneticFilmCylinderTest()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the thin film

gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.9,'Generations',20,'MutationFcn',{@mutationadaptfeasible,0.01},...
    'PopulationSize',5,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
    'TolFun', 1e-10, 'Vectorized','off');
% gaoptions=gaoptimset('CreationFcn',@gacreationlinearfeasible,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',20,...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'TolFun', 1e-10,'Vectorized','off');

%[x,fval,exitFlag]=ga(@(x)objFnc(rtop, rbot, H, a, T),5,[],[],[],[],[],[],...
%    [],gaoptions);


effectiveThickness = 1000*Constants.UnitConversions.NMtoM; % nm
maxPitch = 2000*Constants.UnitConversions.NMtoM;

% constraints are
% 2*rtop < a; 
% 2*rbot < a
% a < maxPitch

%x=[rtop, rbot, a, T]
A = [2 -1 0; 0 1 0;0 0 1]; 
b = [0 maxPitch effectiveThickness]'; 

lowerBound = [0; 0; 0];           %lower bound, T > ET
%ub = []*nmTom;

nVariables = size(A, 1);

[x,fval,exitFlag]=ga(@(x)objFnc(x, effectiveThickness),nVariables,A,b,[],[],lowerBound,[],[], gaoptions);


% define creation function
function pop = createFcn(NVARS,~,options)
  pop = load('firstgeneration.txt');

function UE = objFnc(x, effectiveThickness)

  rtop = x(1);
  %rbot = x(2);
  a = x(2);
  T = x(3);            
  %we get the rtop, rbot, a, T value from the generation. 
  %save('InputVariables', 'rtop', 'rbot', 'a', 'T');

%   H = calculateH(rtop, rbot, a, T, ET);  % calculate H using the calculateH function
%   H = ceil(H/Constants.UnitConversions.NMtoM)*Constants.UnitConversions.NMtoM; % round H to the nearest 1 nm.
%   if H > T
%     UE = 0; % if the length of hole is bigger than T, put the UE as 0, biggest value
%   else


  Input = [rtop; a; T];
  save('Input.txt','Input','-ascii'); % save the variables into txt file so FDTD can load it
  
  % runFDTD(rtop, rbot, a, T, H);
  runFDTD(effectiveThickness);

  materialName = 'Si';
  load('InputVariables');      % load the InputVariables, so we can use the filename
  sr = FDTDSimulationResults(filename);
  ma = MaterialType.create(materialName);
  SS = SolarSpectrum.global_AM1p5();
  sc = SolarCell(SS, sr, ma);
  UE = sc.UltimateEfficiency;
  UE = -UE;                        %the GA algorithm gives out the minimum value, so we negative UE




