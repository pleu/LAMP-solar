%function [ output_args ] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here
  clear;
  ss = SolarSpectrum.global_AM1p5();
  
  materialName = 'Si';
  materialData = MaterialType.create(materialName);
  materialData.OpticalProperties = OpticalProperties('Si Agrawal extrap');
  materialData.BandGap = 1240/1200;
  
  structure = StepFunctionAbsorber('', materialData.BandGap, ss.Energy);
  sc = DetailedSolarCell(ss, structure, materialData);
  
  sc.LimitingEfficiency
  plot([-0.5 sc.IV.Voltage], [sc.IV.CurrentSC sc.IV.CurrentLight]);
  hold on;
  
  plot([-0.5 sc.IV.Voltage], [0 sc.IV.CurrentLight-sc.IV.CurrentSC], 'g');

  ylabel('Current Density (A/m^2)');
  xlabel('Voltage (V)');
  axis([-0.5 1 -500 500]);
  
  %structure2 = ThinFilm(materialData, 2e7);
  %sc2 = DetailedSolarCell(ss, structure2, materialData);
  
  %sc2.LimitingEfficiency

  
%   figure(1);
%   clf; 
%   sc.plotIV
%   
%   plot(sc.IV.Voltage, -sc.IV.CurrentLight+sc.CurrentSC, 'b-')
%   
%   hold on;
%   plot(sc.IV.Voltage, -sc.IV.CurrentLight, 'g-');
%   legend('dark', 'light', 'Location', 'NorthWest');
%   legend boxoff;
%   xlabel('Voltage');
%   ylabel('Current (Amps/m^2)');
%   
%   axis([0 1.0 -1000 2000]);
%   
%   set(gcf, 'Position', [800 500 520 390])
%end

