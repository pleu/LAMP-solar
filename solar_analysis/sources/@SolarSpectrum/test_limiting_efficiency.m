%function test_ultimate_efficiency
% TEST
% tests the SolarSpectrum class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  clear;
  clf;
  ss = SolarSpectrum.global_AM1p5;
  %ss.plot_irradiance_versus_energy;
  limitingEfficiency = ss.plot_limiting_efficiency_versus_energy;
  ylabel('Detailed Solar Cell Efficiency', 'Color', 'b')
  
  add_plotyy(ss.Energy,ss.PhotonFlux/1e21,...
    'Photon Flux (10^{21} photons*m^{-2}eV^{-1})',[0 6],0:1:6, 'Color', 'g')
%   %link_top_axis_data(ss.Energy, ss.Energy, 'Band gap Energy (eV)');
    
 
  %hlink = linkprop([newAxis oldAxis], {'Position','XTick','XScale','XMinorTick'});
      % And store it on the new axis (to make sure it gets updated, but is
      % also destroyed when the figure is closed / axis is deleted)
  %  setappdata(newAxis,'Axis_Linkage',hlink);
  %[limitingEfficiency] = ss.plot_limiting_efficiency_versus_energy;  
  hold on;
  
  bandgap = 1.43;
  limitingEfficiency(knnsearch(ss.Energy, bandgap))
  %axis([0 4 0 6]);
  %grid on;
  %axis([0 4 0 10]);
  %plot(1.12, interp1(ss.Energy, limitingEfficiency, 1.12), 'ko');