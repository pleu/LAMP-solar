function [scArray] = calc_IV(scArray, thetaX, internalFluoresence)
% PLOT_LIMITING_EFFICIENCY_VERSUS_INDEPENDENTVARIABLE
% Plots efficiency versus 
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  for i = 1:scArray.VariableArray.NumValues
    scArray.SolarCells(i).IV = ...
      DetailedSolarCell.calc_IV(scArray.SolarCells(i).Material.BandGap,...
      scArray.SolarCells(i).Structure.AbsorptionResults,...
      scArray.SolarCells(i).CurrentSC,...
      scArray.SolarCells(i).SolarSpectrum, thetaX, internalFluoresence,...
      scArray.SolarCells(i).Structure.Thickness);
  end
end


