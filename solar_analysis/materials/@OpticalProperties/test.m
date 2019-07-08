%function test()
%TEST 
  clear;
  op(1) = OpticalProperties('Si');
  %op(1) = OpticalProperties('a-Si (Silicon) - Palik (FDTD)');
  
  %op(2) = OpticalProperties('Ge');
  op(2) = OpticalProperties('GaAs');


  figure(1);
  clf; 
  op.plot_log_alpha_versus_wavelength;
  set(gcf, 'Position', [800 500 1440 1040]);
  axis([0 2000 1e-8 1])
  %grid off;
  %axis([0 4 1e-8 1e-1])

  figure(2);
  clf;
  op.plot_log_absorption_length_versus_wavelength;
  set(gcf, 'Position', [800 500 1440 1040]);
  axis([0 2000 1 1e5])

  figure(3);
  clf;
  op.plot_log_alpha_versus_energy;
%   set(gcf, 'Position', [800 500 1440 1040]);
%   axis([0 4 1 1e5])
% 
%   figure(4);
%   clf;
    %op.plot_log_alpha_versus_wavelength;
%   set(gcf, 'Position', [800 500 1440 1040]);
%   axis([0 2000 1e-8 1e-1])
% 
%   figure(5);
%   clf;
%   op.plot_refractive_index_versus_wavelength(5);
%   
%   figure(7);
%   clf;
%   op.loglog_refractive_index_versus_wavelength(7);
  
%end

