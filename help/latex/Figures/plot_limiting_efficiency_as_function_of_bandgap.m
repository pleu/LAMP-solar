clear;
%function plot_limiting_efficiency_as_function_of_bandgap()
%PLOT_LIMITING_EFFICIENCY_AS_FUNCTION_OF_BANDGAP
% Plot limiting efficiency as function of band gap.
% Limiting efficiency includes effects of radiative recombination.
% 
% See also PLOT_ULTIMATE_EFFICIENCY_AS_FUNCTION_OF_BANDGAP
% 
% Copyright 2011
% Paul Leu

  clear;
  ss = SolarSpectrum.global_AM1p5;
  bandGap = 1.43; % GaAs
%  ss.plot_ultimate_efficiency_versus_energy;
  
  figure(1);
  clf;
  %[limitingEfficiency] = ss.plot_limiting_efficiency_versus_energy;  
  [limitingEfficiency] = ss.plot_limiting_efficiency_versus_energy2;

  hold on;
  plot(bandGap, interp1(ss.Energy, limitingEfficiency, bandGap), 'ko');

  mTextBox = uicontrol('style','text')
  set(mTextBox,'String','Si')
  set(mTextBox, 'FontSize', 26);
  set(mTextBox, 'BackgroundColor', [1 1 1]);
  set(mTextBox,'Position', [215 375 30 25]);
%  set(mTextBox,'Position', [50 50 60 20]);

  mTextBoxPosition = get(mTextBox,'Position')