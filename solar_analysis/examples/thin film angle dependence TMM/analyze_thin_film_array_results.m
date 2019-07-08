% Analyzes the results from a several FDTD simulations
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh
clear;
%numThetaQuery = 91;

load('InputVariables');
variableValues = thetaArray;
%variableValues = variableValues(10:19);
minTheta = min(variableValues);
variableNames = cellstr(variableStringArray);
variableUnits = cellstr(variableUnitsArray);

ss = SolarSpectrum.global_AM1p5;

va = VariableArray(variableNames, variableUnits, variableValues);
va.Names = {''};
va.create_filenames('SiThinFilmTheta');

ma = MaterialType.create(materialName);

%figure(1); 
%sca.SolarCells.Structure.plot_results_versus_energy;
%scArray.plot_RTA_results_versus_wavelength(4);

%sr = FDTDSimulationResults.create_array(va.Filenames, 'frequency');


[rtS, rtP] = SimulationArray.read_TMM_file(filename);

rtS = rtS.mirror;

%rtS.contour('Wavelength', 'Theta', 'Absorption',200,0);
figure(1);
clf;
rtS.contour('Wavelength', 'Theta', 'Transmission',200,0);
% figure(2);
% clf;
% rtS.contour('Energy', 'Theta', 'Absorption',200,0);

figure(3);
clf;
rtS.contour('Wavelength', 'Theta', 'Absorption',200,0, 'polar');


figure(4);
clf;
rtS.contour('Energy', 'Theta', 'Absorption',200,0, 'polar');



