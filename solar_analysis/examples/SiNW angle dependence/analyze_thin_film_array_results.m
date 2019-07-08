function analyze_thin_film_array_results()
%ANALYZE_THIN_FILM_ARRAY_RESULTS
% Analyzes the results from a several FDTD simulation
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh

AM0 = 1;
GLOBAL_AM1p5 = 2;
DIRECT_AND_CIRCUMSOLAR_AM1p5 = 3;

load('InputVariables');
ThetaArray=linspace(minTheta,maxTheta,numTheta);
PhiArray=linspace(minPhi,maxPhi,numPhi);
numSimulations=numTheta*numPhi;
variableArray=zeros(numSimulations,2);
for i=1:numTheta
    k=numTheta*i-numTheta+1;
    j=numTheta*i;
    variableArray(k:j,1)=ThetaArray(i);
end;
for i=1:numPhi
    k=numPhi*i-numPhi+1;
    j=numPhi*i;
    variableArray(k:j,2)=PhiArray;
end;
variableStringArray = cellstr(variableStringArray);
variableUnitsArray = cellstr(variableUnitsArray);

solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM1p5);
sr = AngleDependenceResultsArray(filenamePrefix, filenameSuffix,...
      numTheta, variableArray, variableStringArray, variableUnitsArray,...
      materialName, solarSpectrum);

sr.plot_UE_versus_variable(7);