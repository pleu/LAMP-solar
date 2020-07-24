function solarSpectrum = read_ASTMG173(option)
%READ_ASTMG173 
% Reads in ASTMG173 data 

  %ASTMG173=load([LAMPsolar_data_path, '/solar_spectrum/ASTMG173.txt']);
  dataStartLine = 3;
  varNames = {'Wavelength', 'AM', 'AM1p5G', 'AM1p5D'};
  varTypes = {'double', 'double', 'double', 'double'};
  opts = delimitedTextImportOptions('VariableNames', varNames, 'VariableTypes', varTypes, 'DataLines', dataStartLine);
  %ASTMG173=readmatrix([LAMPsolar_data_path, '/solar_spectrum/ASTMG173.csv'], opts);
  ASTMG173=table2array(readtable([LAMPsolar_data_path, '/solar_spectrum/ASTMG173.csv'], opts));
  switch option
    case 1
      solarSpectrum = SolarSpectrum('AM0 (ASTM E490)', ASTMG173(:, 1), ASTMG173(:, 2)); 
    case 2
      solarSpectrum = SolarSpectrum('AM1.5 Global (ASTMG173)', ASTMG173(:, 1), ASTMG173(:, 3));
    case 3
      solarSpectrum = SolarSpectrum('AM1.5 Direct+circumsolar (ASTMG173)', ASTMG173(:, 1), ASTMG173(:, 4));
  end
end



