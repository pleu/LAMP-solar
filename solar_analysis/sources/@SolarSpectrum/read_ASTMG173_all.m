function objArray = read_ASTMG173_all()
%READ_ASTMG173_ALL 
% Read in all of ASTMG173 data 
% 
% See also SolarSpectrum
%
% Copyright 2011
% Paul Leu
  numSpectrums = 3;

  for ind = 1:numSpectrums
    objArray(ind) = SolarSpectrum.read_ASTMG173(ind);
  end
end


