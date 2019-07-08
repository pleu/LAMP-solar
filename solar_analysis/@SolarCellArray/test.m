function test
% TEST
% tests the SolarSpectrum class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh

  thicknessArray = [200 2000];
  materialName = 'Si';

  va = VariableArray('thickness', 'nm', thicknessArray);

  material = MaterialType.create(materialName);
  tfArray = DoublePass.create_array(thicknessArray, material);
  
  ss = SolarSpectrum.global_AM1p5;
  
  [scArray] = SolarCellArray.create(ss, tfArray, va, material);
  scArray.UltimateEfficiency

  tfArray2 = Lambertian.create_array(thicknessArray, material);
  [scArray2] = SolarCellArray.create(ss, tfArray2, va, material);
  scArray2.UltimateEfficiency
