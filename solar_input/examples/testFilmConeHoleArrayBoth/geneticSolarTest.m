function [x, fval, exitFlag] = geneticSolarTest()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the thin film

gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.7,'Generations',100,'MutationFcn',{@mutationadaptfeasible,0.05},...
    'PopulationSize',20,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionroulette,'StallGenLimit',10,...
    'TolFun', 1e-10, 'Vectorized','off', 'Display', 'diagnose','PlotFcns',{@gaplotbestf,@gaplotstopping});
% gaoptions=gaoptimset('CreationFcn',@gacreationlinearfeasible,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',100,...
%     'PopulationSize',10,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'TolFun', 1e-10,'Vectorized','off');

%[x,fval,exitFlag]=ga(@(x)objFnc(rtop, rbot, H, a, T),5,[],[],[],[],[],[],...
%    [],gaoptions);


effectiveThickness = 100*Constants.UnitConversions.NMtoM; % nm
maxPitch = 1000*Constants.UnitConversions.NMtoM;
maxlength = 50000*Constants.UnitConversions.NMtoM;
% constraints are
% 2*rtop < a; 
% 2*rbot < a
% a < maxPitch

%x=[rtop, rbot, a, T]
%A = [2 0 0 0 0 -1 0; 0 2 0 0 0 -1 0; 0 0 1 0 0 0 -1;0 0 0 2 0 -1 0; 0 0 0 0 2 -1 0];
A = [2*ntop 0 0 0 0 -1 0 0 0; 0 2*ntop 0 0 0 -1 0 0 0; 0 0 1 0 0 0 -1 0 0; 0 0 0 2*nbot 0 -1 0 0 0; 0 0 0 0 2*nbot -1 0 0 0];
b = [0 0 0 0 0]'; 


lowerBound = [0; 0; 0; 0; 0; 0; effectiveThickness; 1; 1]';           %lower bound, T > ET
%ub = []*nmTom;
upperBound = [maxPitch/2; maxPitch/2; maxlength; maxPitch/2; maxPitch/2; maxPitch; maxlength; 4; 4]'; 
nVariables = size(A, 2);

[x,fval,exitFlag]=ga(@(x)objFnc(x, effectiveThickness),nVariables,A,b,[],[],lowerBound,upperBound,[], gaoptions);


% define creation function
function pop = createFcn(NVARS,~,options)
  pop = load('firstgeneration.txt');

function UE = objFnc(x, effectiveThickness)

  Toprtop = x(1);
  Toprbot = x(2);
  TopConezSpan = x(3);
  Botrtop = x(4);            
  Botrbot = x(5);
  a = x(6);
  T = x(7);
  ntop = x(8);
  nbot = x(9);
  %we get the rtop, rbot, a, T value from the generation. 
  %save('InputVariables', 'rtop', 'rbot', 'a', 'T');

  BotConezSpan = (3*a^2*(T- effectiveThickness)/pi-(Toprtop^2+Toprtop*Toprbot+Toprbot^2)*TopConezSpan*ntop^2)/(Botrtop^2+Botrtop*Botrbot+Botrbot^2)/nbot^2;  % calculate H using the calculateH function
%   H = ceil(H/Constants.UnitConversions.NMtoM)*Constants.UnitConversions.NMtoM; % round H to the nearest 1 nm.
 
  if BotConezSpan + TopConezSpan > T || mod(ntop^2, ntop) || mod(nbot^2, nbot) 
  UE = 0; % if the length of hole is bigger than T, put the UE as 0, biggest value
  else
    
%   Input = [rtop; rbot; a; T];
%   save('Input.txt','Input','-ascii'); % save the variables into txt file so FDTD can load it
  
  % runFDTD(rtop, rbot, a, T, H);
  runFDTD(effectiveThickness, T, a, TopConezSpan, Toprtop, Toprbot, ntop, Botrtop, Botrbot, nbot);

  materialName = 'Si';
  load('InputVariables');      % load the InputVariables, so we can use the filename
  sr = FDTDSimulationResults(filename);
  ma = MaterialType.create(materialName);
  SS = SolarSpectrum.global_AM1p5();
  sc = SolarCell(SS, sr, ma);
  UE = sc.UltimateEfficiency;
  UE = -UE;                        %the GA algorithm gives out the minimum value, so we negative UE
  end



