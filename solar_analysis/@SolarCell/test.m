function test()

  material = MaterialType.create('Si');
  ss = SolarSpectrum.global_AM1p5;
  sfa = StepFunctionAbsorber('Si', material.BandGap, ss.Energy);
  %(solarSpectrum, structure, material)

  sc = SolarCell(ss, sfa, material);
%  sc = sc.calculate_limiting_efficiency(material.BandGap);

  figure(1);
  clf;
%  sc.SQSimulation.plot_IV;

  disp(['Ultimate Efficiency: ', num2str(sc.UltimateEfficiency)]);
%  disp(['Limiting Efficiency: ', num2str(sc.LimitingEfficiency)]);


end

