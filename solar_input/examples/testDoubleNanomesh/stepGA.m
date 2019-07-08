function [nextScore,nextPopulation,state] = stepGA(thisScore,thisPopulation,options,state,GenomeLength,FitnessFcn)
%STEPGA Moves the genetic algorithm forward by one generation
%   This function is private to GA.

%   Copyright 2003-2007 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2009/08/29 08:27:20 $

% how many crossover offspring will there be from each source?

suffix = load('suffix.txt');
Populationfilename = ['population', num2str(suffix), '.txt'];
Scorefilename = ['UE', num2str(suffix), '.txt'];
save(Populationfilename, 'thisPopulation', '-ascii');
save(Scorefilename, 'thisScore', '-ascii');
minScore = min(thisScore);
figure(1);
plot(suffix, minScore,'*');
hold on;

population = load(Populationfilename);
if ~mod(size(population,1), 5) 
  suffix = suffix + 1;
else
  suffix = suffix;
end

save('suffix.txt', 'suffix', '-ascii');
nEliteKids = options.EliteCount;
nXoverKids = round(options.CrossoverFraction * (size(thisPopulation,1) - nEliteKids));
nMutateKids = size(thisPopulation,1) - nEliteKids - nXoverKids;
% how many parents will we need to complete the population?
nParents = 2 * nXoverKids + nMutateKids;

% decide who will contribute to the next generation

% fitness scaling
state.Expectation = feval(options.FitnessScalingFcn,thisScore,nParents,options.FitnessScalingFcnArgs{:});

% selection. parents are indices into thispopulation
parents = feval(options.SelectionFcn,state.Expectation,nParents,options,options.SelectionFcnArgs{:});

% shuffle to prevent locality effects. It is not the responsibility
% if the selection function to return parents in a "good" order so
% we make sure there is a random order here.
parents = parents(randperm(length(parents)));

[unused,k] = sort(thisScore);

% Everyones parents are stored here for genealogy display
state.Selection = [k(1:options.EliteCount);parents'];

% here we make all of the members of the next generation
eliteKids  = thisPopulation(k(1:options.EliteCount),:);
xoverKids  = feval(options.CrossoverFcn, parents(1:(2 * nXoverKids)),options,GenomeLength,FitnessFcn,thisScore,thisPopulation,options.CrossoverFcnArgs{:});
mutateKids = feval(options.MutationFcn,  parents((1 + 2 * nXoverKids):end), options,GenomeLength,FitnessFcn,state,thisScore,thisPopulation,options.MutationFcnArgs{:});

% group them into the next generation
nextPopulation = [ eliteKids ; xoverKids ; mutateKids ];
nextPopulation = ceil(nextPopulation/20e-9)*20e-9;


% score the population
%We want to add the vectorizer if fitness function is NOT vectorized
if strcmpi(options.Vectorized, 'off') 
    nextScore = fcnvectorizer(nextPopulation,FitnessFcn,1,options.SerialUserFcn);
else
    nextScore = FitnessFcn(nextPopulation);
end 
% Make sure score is a column vector
nextScore = nextScore(:);


state.FunEval = state.FunEval + size(nextScore,1);


