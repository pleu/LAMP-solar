function analyze_SiNW_array_results()
%ANALYZE_SINW_ARRAY_RESULTS
% Analyzes the results from a several FDTD simulation
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Baomin Wang
% LAMP, University of Pittsburgh

AM0 = 1;
GLOBAL_AM1p5 = 2;
DIRECT_AND_CIRCUMSOLAR_AM1p5 = 3;

load('InputVariables_contour');

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
sr = FDTDSimulationResultsArray(filenamePrefix, filenameSuffix,...
      numSimulations, variableArray, variableStringArray, variableUnitsArray,...
      materialName, independentVariable);

sr.contourplot_UE_results_versus_variables;

zlabel('EQE');
set(gca,'Fontsize',16);
set(gca,'XTick',0:5:55);
set(gca,'YTick',0:5:55);
