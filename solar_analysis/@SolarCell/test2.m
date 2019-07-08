  material = MaterialType.create('Si');
  ss = SolarSpectrum.global_AM1p5;
  sfa = StepFunctionAbsorber('Si', material.BandGap, ss.Energy);
  %(solarSpectrum, structure, material)

  
  sc = SolarCell(ss, sfa, material);
  
  thickness = 20000; % in nm
  materialName = 'Si';

  materialData = MaterialType.create(materialName);
  tf = DoublePass(materialData, thickness);
  
  figure(1);
  sfa.plot_absorption('Energy');
  hold on;
  tf.plot_absorption('Energy');
  
  sc2 = SolarCell(ss, tf, material);
 