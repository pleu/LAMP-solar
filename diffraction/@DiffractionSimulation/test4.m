%TEST4 Summary of this function goes here
%   Detailed explanation goes here

pitch = [400 500 600 700];
lattice = [1 0; 1/2 sqrt(3)/2];
number = [inf inf];

diameter = [500 600];
wavelength = [400 450];
%linspace(400, 700);

variableNames = {'pitch', 'diameter'};
variableUnits = {'nm', 'nm'};
variableArray = {pitch,diameter};

va = VariableArray(variableNames, variableUnits,...
    VariableArray.value_combinations(variableArray));
%va = VariableArray(variableNames, variableUnits, variableArray);
%va = variableArray('diameter', 'nm', diameter);
%st = CircularHoleArray.empty(length(diameter), 0);
%for i = 1:length(diameter)
st = CircularHoleArray.create_array(pitch, lattice, number, diameter);
%end
sc = SolarSpectrum.create_single_wavelength(wavelength);

obj = DiffractionSimulation(st, sc, va);

%save('obj', 'diffractionResults');

% Current issue if there is more than one of other variable
%obj.contour_haze('Wavelength', 'pitch', 'Angle');

figure(1);
clf;
obj.contour_haze('Wavelength', 'pitch', 'Angle', 'diameter', 600);

figure(2);
clf;
obj.contour_haze('diameter', 'pitch', 'Angle', 'wavelength', 400);

figure(3);
clf;
obj.contour_haze('diameter', 'pitch', 'Number', 'wavelength', 400);


%va.contour(xVarString, yVarString, zValues, numContourLines, interpolationMethod)

