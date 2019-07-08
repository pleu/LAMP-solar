thicknessArray = [200 2000];
materialName = 'Si';

va = VariableArray('thickness', 'nm', thicknessArray);

materialData = MaterialType.create(materialName);
tfArray = DoublePass.create_array(thicknessArray, materialData);

figure(1);
clf;
hold on;
tfArray.plot_absorption('Wavelength');

