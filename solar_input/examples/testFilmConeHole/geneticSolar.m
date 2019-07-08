function [x, fval, exitFlag] = geneticSolar()
%rtop, top radius of nanocone
%rbot, bottom radius of nanocone
%a, pitch of the nanocone array
%T, thickness of the 

% gaoptions=gaoptimset('CreationFcn',@createFcn,'CrossoverFcn',@crossoversinglepoint,...
%     'CrossoverFraction',0.8,'Generations',5,'MutationFcn',{@mutate_permutation,0.01},...
%     'PopulationSize',5,'PopulationType','doubleVector',...
%     'SelectionFcn',@selectionroulette,'StallGenLimit',5,...
%     'Vectorized','off');
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
nmTom = 1e-9;
ET = 1000*nmTom; %nm
A = [2 0 -1 0; 0 0 0 0; 0 2 -1 0; 0 0 1 0]; %constrains 2rtop<a, 2rbot<a, a<2000
b = [0 0 0 2000]'*nmTom;                    %x=[rtop, rbot, a T]
lb = [0; 0; 0; ET];                         %lower bound, T > ET
%ub = []*nmTom;

[x,fval,exitFlag]=ga(@(x)objFnc(x, ET),4,A,b,[],[],lb,[],[], gaoptions);


% fval = -fval;

% define creation function
function pop = createFcn(NVARS,~,options)  %create the first generation
pop = load('firstgeneration2.txt');        %load the first generation we spicify 

%x = [rtop, rbot, a, T];
function UE = objFnc(x, ET)
nmTom = 1e-9;
rtop = x(1);
rbot = x(2);
a = x(3);
T = x(4);          %we get the rtop, rbot, a, T value from the generation. 
%save('InputVariables', 'rtop', 'rbot', 'a', 'T');
H = calculateH(rtop, rbot, a, T, ET); % calculate H using the calculateH function
H = ceil(H/nmTom)*nmTom; % round H to the nearest 1 nm.
 if H > T                % if the length of hole is bigger than T, put the UE as 0, biggest value
   UE = 0;
 else
Input = [rtop; rbot; a; T; H];
save('Input.txt','Input','-ascii');  % save the variables into txt file so FDTD can load it
% runFDTD(rtop, rbot, a, T, H);
runFDTD();
materialName = 'Si';
load('InputVariables');              % load the InputVariables, so we can use the filename
sr = FDTDSimulationResults(filename);
ma = MaterialType.create(materialName);
SS = SolarSpectrum.global_AM1p5();
sc = SolarCell(SS, sr, ma);
UE = sc.UltimateEfficiency;
UE = -UE;                            %the GA algorithm gives out the minimum value, so we negative UE
end



