thicknessArray = [2000 50000];
materialName = 'Si';
va = VariableArray('thickness', 'nm', thicknessArray);

%AbsorberType.create('ThinFilm');

materialData = MaterialType.create(materialName);
materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
materialData.BandGap = 1240/1200;

% a{1} = ThinFilm(materialData, 2000)
% a{2} = ThinFilm(materialData, 50000)
% a{3} = Lambertian(materialData, 2000)

tfArray = ThinFilm.create_thin_film_array(va, materialData);

aa = AbsorberArray(tfArray, va.NumValues);

figure(1);
clf;
hold on;

aa(length(thicknessArray)+1).Absorber = Lambertian(materialData, 2000);

bandGap = Photon.ConvertWavelengthToEnergy(1200);
aa(length(thicknessArray)+2).Absorber = StepFunctionAbsorber('Shockley-Queisser Limit',...
  bandGap);
%materialData.plot_shockley_queisser_limit;


aa.plot_absorption('Wavelength');
axis([280 1400 0 1]);

%tfArray.
% aa = AbsorberArray(tfArray, va);
% figure(1);
% clf;
% hold on;
% tfArray.plot_absorption('Wavelength');
% 
% lambertian = Lambertian(materialData, 2000);
% lambertian.plot_absorption('Wavelength', 'r');
% 
% aa.Absorbers(3) = Lambertian(materialData, 2000);

