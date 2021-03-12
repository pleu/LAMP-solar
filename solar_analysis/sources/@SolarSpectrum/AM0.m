function solarSpectrum = AM0()
% Reads in Global AM0 data 
  AM0 = 1;
  solarSpectrum = SolarSpectrum.read_ASTMG173(AM0);
end

