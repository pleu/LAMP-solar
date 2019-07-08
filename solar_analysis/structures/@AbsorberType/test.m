thicknessArray = [2000 50000];
materialName = 'Si';
va = VariableArray('thickness', 'nm', thicknessArray);

AbsorberType.create('ThinFilm');

materialData = MaterialType.create(materialName);
materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
materialData.BandGap = 1240/1200;

tfArray = ThinFilm.create_thin_film_array(va, materialData);