clear;
minThickness = 2000; % nm
maxThickness = 2e7; % nm
thicknessArray = 10.^(linspace(log10(minThickness), log10(maxThickness)));

%thicknessArray = [1e5 2e7];

va = VariableArray('thickness', 'nm', thicknessArray);

materialName = 'Si';
materialData = MaterialType.create(materialName);
materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
materialData.BandGap = 1240/1200;

solarSpectrum = SolarSpectrum.global_AM1p5;

tfArray = ThinFilm.create_thin_film_array(va, materialData);


scArray = DetailedSolarCellArray.create(...
  solarSpectrum, va, tfArray, materialData);

scArray.VariableArray = VariableArray('thickness', 'microns', thicknessArray/1000);

scArray.semilogx_limiting_efficiency_versus_variable('thickness');
set(gcf, 'Position', [800 500 1440 1040]);
grid on;
axis([1e-1 2e3 0.15 0.35]);
hold on;

% plot SQ limiting efficiency

% this is with 1.12
%semilogx([1e-1 2e3], [0.3326 0.3326], 'r')

% this is with modified band gap
semilogx([1e-1 2e3], [0.3234 0.3234], 'r')