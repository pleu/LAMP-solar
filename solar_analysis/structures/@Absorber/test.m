thicknessArray = [2000 50000];
materialName = 'Si';


va = VariableArray('thickness', 'nm', thicknessArray);

materialData = MaterialType.create(materialName);
materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
materialData.BandGap = 1240/1200;

tfArray = ThinFilm.create_thin_film_array(va, materialData);


tfArray(3) = Lambertian('thickness', 'nm', 2000)

figure(1);
clf;
hold on;
tfArray.plot_absorption('Wavelength');
legend('boxoff');
axis([280 1400 0 1]);
