function plot_absorption_versus_energy(scArray)
% PLOT_ABSORPTION_VERSUS_ENERGY
% Plots absorption data versus photon energy
% 
% See also PLOT_ABSORPTION_VERSUS_WAVELENGTH
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  color = ('bgcmy');
  legendArray = cell(scArray.NumSolarCell,1);
  
  for i = 1:scArray.NumSolarCell
    scArray.SolarCell(i).Structure.AbsorptionResults.plot_versus_energy('Color', color(i));
    hold on;
    legendArray{i} = [scArray.SolarCell(i).Structure.Name];
  end
  legend(legendArray);
  %axis([0 max(obj.Energy) 0 1]);
end


