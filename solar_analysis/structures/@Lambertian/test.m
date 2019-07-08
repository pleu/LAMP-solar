thicknessArray = [684 2000];
materialName = 'Si';

va = VariableArray('thickness', 'nm', thicknessArray);

materialData = MaterialType.create(materialName);
tfArray = Lambertian.create_array(thicknessArray, materialData);


figure(1);
clf;
hold on;
tfArray.plot_absorption('Wavelength');
legend('boxoff');

sc = SolarCellArray.create(SS, tfArray, va, ma);




