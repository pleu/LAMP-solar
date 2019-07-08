function solarSpectrum = global_AM0()
% Reads in Global AM0 data 
  GLOBAL_AM0 = 1;
  solarSpectrum = SolarSpectrum.read_ASTMG173(GLOBAL_AM0);
end

