%ANALYZE_TRANSPARENT_CONDUCTOR_ARRAY_RESULTS
% Analyzes the results from a several FDTD simulation
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2012
% Paul W. Leu
clear;
hold on;


ss = SolarSpectrum.global_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 2000);

load('InputVariablesTM');
variableStringArray = {'d', 'p'};
variableUnitsArray = {'nm', 'nm'};
% preallocate variableArray
incrementDiameter = 50e-9;

pitchArray = [50 100 150];
diameterArray = [50 100 150];
variables = {diameterArray, pitchArray};
variables = VariableArray.value_combinations(variables);
variables = variables(variables(:, 1) <= variables(:, 2), :);

va = VariableArray(variableStringArray, variableUnitsArray, variables);
va.create_filenames('AgNWTM');  

material = MaterialType.create(materialName);

tcArrayTM = TransparentConductorArray.create_circle_array(ss, va, material, 'frequency');
figure(1);
clf;

va.create_filenames('AgNWTE');  
tcArrayTE = TransparentConductorArray.create_circle_array(ss, va, material, 'frequency');

tAvg = (tcArrayTM.Transmission+ tcArrayTE.Transmission)/2;
RsAvg = (tcArrayTM.SheetResistance + tcArrayTE.SheetResistance)/2;

tcArrayTE.VariableArray.contour('p', 'd', tAvg) 

figure(2);
clf;
plot(RsAvg, tAvg, 'r+');
xlabel('Sheet Resistance (\Omega/square)');
ylabel('Solar Transmission')


figure(3);
clf;
[va2, index] = va.get_sub_variable_array('d', 50);
va2.plot(tAvg(index), 'Solar Transmission');
[va2, index] = va.get_sub_variable_array('d', 100);
va2.plot(tAvg(index), 'Solar Transmission');




