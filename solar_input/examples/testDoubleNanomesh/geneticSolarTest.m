function [x, fval, exitFlag] = geneticSolarTest()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the thin film


% gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',100,'MutationFcn',{@mutationadaptfeasible,0.01},...
%     'PopulationSize',20,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',10,...
%     'TolFun', 1e-10, 'Vectorized','off');

gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.7,'Generations',50,'MutationFcn',{@mutationadaptfeasible,0.05},...
    'PopulationSize',20,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionuniform,'StallGenLimit',10,...
    'TolFun', 1e-10, 'Vectorized','off', 'Display', 'diagnose','PlotFcns',{@gaplotbestf,@gaplotstopping});

% gaoptions=gaoptimset('CreationFcn',@gacreationlinearfeasible,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',20,...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'TolFun', 1e-10,'Vectorized','off');

%[x,fval,exitFlag]=ga(@(x)objFnc(rtop, rbot, H, a, T),5,[],[],[],[],[],[],...
%    [],gaoptions);


% effectiveThickness = 1000*Constants.UnitConversions.NMtoM; % nm
maxPitch = 1400*Constants.UnitConversions.NMtoM;
maxTopThickness = 200*Constants.UnitConversions.NMtoM;
maxBottomThickness = 500*Constants.UnitConversions.NMtoM;


% constraints are
% 2*rtop < a; 
% 2*rbot < a
% a < maxPitch
% ttop < maxttop;
% tbot < maxtbot;

%x=[rtop, rbot, a, T]
A = [2 -1 0 0 0; 0 2 -1 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1]; 
b = [0 0 maxPitch maxTopThickness maxBottomThickness]'; 

lowerBound = [0; 0; 400e-9; 20e-9; 20e-9];           %lower bound, T > ET
upperBound = [2000e-9; 2000e-9; 2000e-9; 2000e-9; 2000e-9];
%ub = []*nmTom;

nVariables = size(A, 1);

[x,fval,exitFlag]=ga(@(x)objFnc(x),nVariables,A,b,[],[],lowerBound,upperBound, [], gaoptions);


% define creation function
function pop = createFcn(NVARS,~,options)
  pop = load('firstgeneration.txt');
  
  


function UE = objFnc(x)

%   RejectionCutoff = 600;   % in nm
%   WindowWavelength = [265,300];

  rtop = x(1);
  rbot = x(2);
  a = x(3);
  ttop = x(4);
  tbot = x(5);
  
  activeFilmzSpan = 300*Constants.UnitConversions.NMtoM;

  
  %we get the rtop, rbot, a, T value from the generation. 
  %save('InputVariables', 'rtop', 'rbot', 'a', 'T');

%   H = 3*(T-effectiveThickness)*a^2/pi/(rtop^2+rtop*rbot+rbot^2);  % calculate H using the calculateH function
% %   H = ceil(H/Constants.UnitConversions.NMtoM)*Constants.UnitConversions.NMtoM; % round H to the nearest 1 nm.
%  
%   if H > T
%   RR = 0; % if the length of hole is bigger than T, put the UE as 0, biggest value
%   else
    
%   Input = [ttop, tbot, activeFilmzSpan, xSpan, rtop, rbot];
%   save('Input.txt','Input','-ascii'); % save the variables into txt file so FDTD can load it
  
  % runFDTD(rtop, rbot, a, T, H);
%   runFDTD();

%   materialName = 'Al';
%   load('InputVariables');      % load the InputVariables, so we can use the filename
%   sr = OpticalFilter(filename,'frequency',282.5,RejectionCutoff);
  
  runFDTD(ttop, tbot, activeFilmzSpan, a, rtop, rbot);


  materialName = 'Si';
  load('InputVariables');      % load the InputVariables, so we can use the filename
  
  sr = FDTDSimulationResults.read_absorption_file(filename, 'frequency');
    
  ma = MaterialType.create(materialName);
  SS = SolarSpectrum.global_AM1p5();
  sc = SolarCell(SS, sr, ma);
  UE = sc.UltimateEfficiency;
  UE = -UE;       
%   end
  

