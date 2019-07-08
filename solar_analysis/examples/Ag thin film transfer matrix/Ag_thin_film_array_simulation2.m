clear;
materials = {'Air'; 'Si'; 'Ge'; 'Air'};
solarSpectrum = SolarSpectrum.global_AM1p5();
solarSpectrum = solarSpectrum.truncate_spectrum_wavelength(280, 2000);

thicknessVector = [50]';
%thicknessVector = [1 2 3 4 5 10 20 30 40 50 60 70 80 90 100]';
names = {'t1', 't2'};
units = {'nm', 'nm'};
%thicknessVector2 = [1 2 3 4 5 10 20 30 40 50 60 70 80 90 100]';
thicknessVector2 = [50]';

values = {thicknessVector,thicknessVector2};

%values2 = VariableArray.valueCombinations(values);

va = VariableArray.create_variable_combinations(names, units, values);
%va = VariableArray(variableString, variableUnitsArray, variableArray);
tma = TransferMatrixSimulation.create_array(solarSpectrum, materials, va);
tmsa = TransferMatrixSimulationArray.create(tma, va);

tmsa.simulate;


% 
% 
% %[tfArray] = ThinFilmLayerStructure.create_thin_film_layer_structure_array(...
% %        solarSpectrum, materials, thicknessArray, thicknessVector);
% 
% for i = 1:numThickneses
%   [tfArray.SolarCell(i)] = tfArray.SolarCell(i).simulate;
% end
% 
% tfArray.plot_RTA_results_versus_variable;
% tfArray.plot_t_vs_rs(4);    
%tm = TransferMatrixSimulation(solarSpectrum, tfArray);
%tm = tm.simulate;