%function test
% TEST
% tests the SolarSpectrum class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  clear;
  variableArray = [10 10; 
    10 20;
    10 100;
    20 20];
  variableNames = {'dtop', 'dbot'};
  variableUnits = {'nm', 'nm'};
  variableArray2 = {[10 20],[20 30]};
  
  va = VariableArray(variableNames, variableUnits, variableArray);
  va2 = VariableArray(variableNames, variableUnits,...
    VariableArray.value_combinations(variableArray2));
  va.create_filenames('SINC', 'test');
  
  variableOut = va.get_variable_values('dbot');
  assert(variableOut(3)==100);
  
  assert(strcmp(va.Filenames{1}, 'SINCdtop10nmdbot10nmtest'));

  assert(strcmp(va.VariableStrings{1}, 'dtop10nmdbot10nm'));

  assert(strcmp(va.VariableStrings{3}, 'dtop10nmdbot100nm'));
  assert(strcmp(va2.VariableStrings{4}, 'dtop20nmdbot30nm'));

  assert(strcmp(va.VariableAxisLabels{1}, 'dtop (nm)'));
  assert(strcmp(va.VariableAxisLabels{2}, 'dbot (nm)'));
  disp('test OK');
%end

