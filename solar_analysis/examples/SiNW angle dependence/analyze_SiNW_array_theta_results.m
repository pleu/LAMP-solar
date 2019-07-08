function analyze_SiNW_array_theta_results()
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

independentVariableType = 'wavelength';

load('InputVariables');
ThetaArray=linspace(minTheta,maxTheta,numTheta);
numSimulations=numTheta;
variableArray=zeros(numSimulations,1);
variableArray(:,1)=ThetaArray;

variableStringArray = cellstr(variableStringArray);
variableUnitsArray = cellstr(variableUnitsArray);
 solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM1p5);
sr = FDTDSimulationResultsArray(filenamePrefix, filenameSuffix,...
      numSimulations, variableArray, variableStringArray, variableUnitsArray,...
      materialName, solarSpectrum, independentVariableType);

sr.plot_RTA_results_versus_wavelength(1);
sr.plot_RTA_results_versus_variable(4);
sr.plot_UE_versus_variable(7);
set(gca,'XTick',ThetaArray);
set(gca,'YTick',0:0.2:1);