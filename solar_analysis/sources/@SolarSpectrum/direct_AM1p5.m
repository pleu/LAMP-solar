function solarSpectrum = direct_AM1p5()
% Reads in Global AM0 data 
  DIRECT_AM1P5 = 3;
  solarSpectrum = SolarSpectrum.read_ASTMG173(DIRECT_AM1P5);
end