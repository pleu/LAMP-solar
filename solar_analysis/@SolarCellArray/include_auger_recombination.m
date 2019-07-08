function scArray = include_auger_recombination(scArray)
% INCLUDE_AUGER_RECOMBINATION 
% Includes Auger recombination in all solar cells
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  for i = 1:scArray.NumSolarCell
    scArray.SolarCell(i).IncludeAugerRecombination = 1;
  end
end

