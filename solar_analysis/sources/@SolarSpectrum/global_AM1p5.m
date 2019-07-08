function solarSpectrum = global_AM1p5()
% Reads in Global AM1.5 data 
  GLOBAL_AM1p5 = 2;
  solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM1p5);
end

