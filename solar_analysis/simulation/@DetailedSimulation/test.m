%function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
  ss = SolarSpectrum.global_AM1p5();
  ma = MaterialType.create('Si');
  structure = StepFunctionAbsorber('', ma.BandGap, ss.Energy);
  sc = DetailedSolarCell(ss, structure, ma)  
  sc.plotIV

%end

