function plot_absorption_versus_wavelength(scArray)
% PLOT_ABSORPTION_VERSUS_WAVELENGTH
% Plots absorption data versus photon energy
% 
% See also PLOT_ABSORPTION_VERSUS_ENERGY
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh

  %color = ('bgmcy');
  colororder = [
      0.00 0.50  0.00
    0.00 1.00  0.40
  0.7 1.00  0.00
  0.0 0.00  1.00
  0.00 0.00  1.00
  0.5  0.00  1.00
  1.00  0.00  0.00
	0.00  0.00  1.00
	0.00  0.50  0.00
	1.00  0.00  0.00
	0.00  0.75  0.75
	0.75  0.00  0.75
	0.75  0.75  0.00
	0.25  0.25  0.25
	0.75  0.25  0.25
	0.95  0.95  0.00
	0.25  0.25  0.75
	0.75  0.75  0.75
	0.00  1.00  0.00
	0.76  0.57  0.17
	0.54  0.63  0.22
	0.34  0.57  0.92
	1.00  0.10  0.60
	0.88  0.75  0.73
	0.10  0.49  0.47
	0.66  0.34  0.65
	0.99  0.41  0.23];
  legendArray = cell(scArray.NumSolarCell,1);
  
  for i = 1:scArray.NumSolarCell
%     if scArray.NumSolarCell> 5
       scArray.SolarCell(i).Structure.AbsorptionResults.plot_versus_wavelength('Color', colororder(i, :));
%     else
%       scArray.SolarCell(i).Structure.AbsorptionResults.plot_versus_wavelength('Color', color(i));
%    end
    hold on;
    legendArray{i} = [scArray.SolarCell(i).Structure.Name];
  end
  legend(legendArray);
  %axis([0 max(obj.Energy) 0 1]);
end


