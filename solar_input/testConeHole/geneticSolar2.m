function [x, fval, exitFlag] = geneticSolar2()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the 

% gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.8,'Generations',5,'MutationFcn',{@mutate_permutation,0.01},...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'Vectorized','off');
gaoptions=gaoptimset('CreationFcn',@gacreationlinearfeasible,'CrossoverFcn',@crossoversinglepoint,...
    'CrossoverFraction',0.9,'Generations',20,'MutationFcn',{@mutationadaptfeasible,0.01},...
    'PopulationSize',5,'PopulationType','doubleVector',...
    'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
    'TolFun', 1e-10, 'Vectorized','off');
% gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.9,'Generations',20,...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'TolFun', 1e-10,'Vectorized','off');

%[x,fval,exitFlag]=ga(@(x)objFnc(rtop, rbot, H, a, T),5,[],[],[],[],[],[],...
%    [],gaoptions);
nmTom = 1e-9;
% ET = 1000*nmTom; %nm
% A = [2 0 -1 0; 0 0 0 0; 0 2 -1 0; 0 0 1 0];
% b = [0 0 0 2000]'*nmTom;
% lb = [0; 0; 0; ET];
%ub = []*nmTom;
ET = 100*nmTom; %nm
A = [2 0 -1 0 0; 0 0 0 1 0; 0 2 -1 0 0; 0 0 1 0 0; 0 0 0 -1 1];
b = [0 1000 0 200 0]'*nmTom;
lb = [0; 0; 0; ET; 0];
%[x,fval,exitFlag]=ga(@(x)objFnc(x, ET),4,A,b,[],[],lb,[],[], gaoptions);
[x,fval,exitFlag]=ga(@(x)objFnc(x),5,A,b,[],[],lb,[],[], gaoptions);
x(5) = calculateH(x(1), x(2), x(3), x(4), ET);

%fval = -fval;

% define creation function
% function pop = createFcn(NVARS,~,options)
% pop = load('firstgeneration2.txt');

%x = [rtop, rbot, a, T];
%function UE = objFnc(x, ET)
function UE = objFnc(x)
%function UE = objFnc(rtop, rbot, a, T)

rtop = x(1);
rbot = x(2);
a = x(3);
T = x(4);
H = x(5);
%save('InputVariables', 'rtop', 'rbot', 'a', 'T');
%H = calculateH(rtop, rbot, a, T, ET);
% if H > T
%   UE = 0;
% else
Input = [rtop; rbot; a; T; H];
save('Input.txt','Input','-ascii');
runFDTD();
materialName = 'Si';
load('InputVariables');
sr = FDTDSimulationResults(filename);
ma = MaterialType.create(materialName);
SS = SolarSpectrum.global_AM1p5();
sc = SolarCell(SS, sr, ma);
UE = sc.UltimateEfficiency;
UE = -UE;
%end



