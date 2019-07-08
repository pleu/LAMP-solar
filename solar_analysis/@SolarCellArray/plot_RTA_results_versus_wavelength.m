function plot_RTA_results_versus_wavelength(sr, figureNumber, varargin)
%PLOT_RTA_RESULTS
% Plots the reflection, transmission, and absorption versus wavelength
% 
%% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh

  colorArray = varycolor(sr.NumSolarCell);
  legendArray = cell(sr.NumSolarCell, 1);
  for iSim = 1:sr.NumSolarCell
    colorOption = {'Color', colorArray(iSim, :)};
    
      
    legendArray{iSim} = [char(sr.IndependentVariableLabel), ' = ',...
      num2str(sr.IndependentVariable(iSim)), ' ', ...
      char(sr.IndependentVariableUnits)];
        
    if nargin == 1
      figureNumber = 1;
    end
    
    figure(0 + figureNumber);
    SetFigure(iSim);
    sr.SolarCell(iSim).Structure.ReflectionResults.plot_versus_wavelength(colorOption{:});
    if iSim == sr.NumSolarCell
      legend(legendArray);  
    end
    figure(1 + figureNumber);
    SetFigure(iSim);
    
    sr.SolarCell(iSim).Structure.TransmissionResults.plot_versus_wavelength(colorOption{:});

    if iSim == sr.NumSolarCell
      legend(legendArray);  
    end
    
    figure(2 + figureNumber);
    SetFigure(iSim);
    sr.SolarCell(iSim).Structure.AbsorptionResults.plot_versus_wavelength(colorOption{:});

    if iSim == sr.NumSolarCell
      legend(legendArray);  
    end
    
    %% get options
  end
end
