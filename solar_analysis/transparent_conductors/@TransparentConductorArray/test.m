function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
SS = SolarSpectrum.global_AM1p5;

materialName = 'Cu';
material = MaterialType.create(materialName);

variableStringArray = {'t'};
variableUnitsArray = {'nm'};
thicknessArray = 1:3;
va = VariableArray(variableStringArray, variableUnitsArray, thicknessArray);
va.create_filenames('CuThinFilm');

tfArray = TransparentConductorArray.create_thin_film_array(SS, va, material, 'frequency');


end

