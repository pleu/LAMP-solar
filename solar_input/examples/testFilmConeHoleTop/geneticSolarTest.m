function [x, fval, exitFlag] = geneticSolarTest()
% This optimizes ultimate efficiency for the nanocone hole structure 
% on top of a film using a genetic algorithm.  
% 
% Four parameters that are varied:
% rtop, top radius of nanocone hole
% rbot, bottom radius of nanocone hole
% a, pitch of the nanocone hole array
% T, thickness of the thin film
%
% Copyright 2011
% Baomin Wang


gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.9,'Generations',100,'MutationFcn',{@mutationadaptfeasible,0.01},...
    'PopulationSize',20,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
    'TolFun', 1e-10, 'Vectorized','off');
effectiveThickness = 1000*Constants.UnitConversions.NMtoM; % nm

% we choose this because 
maxPitch = 1000*Constants.UnitConversions.NMtoM; % max pitch of optimization

% constraints for implementation are
% 2*rtop <= a; 
% 2*rbot <= a
% x=[rtop, rbot, a, T]
% Ax <=b
A = [2 0 -1 0; 0 2 -1 0]; 
b = [0 0]'; 


arbitraryUpperBound = 1e4; % in meters
lowerBound = [0; 0; 0; effectiveThickness];  % ET < T < ET/(1 - pi/4)
upperBound = [arbitraryUpperBound; arbitraryUpperBound; maxPitch; effectiveThickness/(1-pi/4)]; 
nVariables = size(A, 2);

[x,fval,exitFlag]=ga(@(x)objFnc(x, effectiveThickness),nVariables,A,b,[],[],lowerBound,upperBound,[], gaoptions);


% define creation function
function pop = createFcn(NVARS,~,options)
  pop = load('firstgeneration.txt');

function UE = objFnc(x, effectiveThickness)
  rtop = x(1);
  rbot = x(2);
  a = x(3);
  T = x(4);            

  H = 3*(T-effectiveThickness)*a^2/pi/(rtop^2+rtop*rbot+rbot^2);  % height of the hole
 
  if H > T
    UE = 0; % if the length of hole is bigger than T, put the UE as 0, biggest value
  else
    
    runFDTD(effectiveThickness, T, a, rtop, rbot);

    materialName = 'Si';
    load('InputVariables');      % load the InputVariables, so we can use the filename
    sr = FDTDSimulationResults(filename);
    ma = MaterialType.create(materialName);
    SS = SolarSpectrum.global_AM1p5();
    sc = SolarCell(SS, sr, ma);
    UE = sc.UltimateEfficiency;
    UE = -UE;                        %the GA algorithm gives out the minimum value, so we negative UE
  end
  


