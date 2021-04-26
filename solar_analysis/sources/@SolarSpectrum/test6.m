function test6
% TEST
% tests the SolarSpectrum class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  ss = SolarSpectrum.global_AM1p5;
  ss.plot_limiting_efficiency_versus_energy()

end

