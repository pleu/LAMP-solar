classdef DoublePass < Absorber
% ThinFilm class for solar cell
% Considers varying absoprtion coefficient
% Assumes perfectly reflecting back surface and perfectly antireflecting
% front surface
%
% See also SolarSpectrum, MaterialData, SolarCell
% 
% Copyright 2011
% Paul Leu 
  properties
    Name; % description of file
    MaterialData;
    Thickness;  % in nm
    AbsorptionResults; % this is monitor object
    % absorption for perfectly reflecting back surface and pefectly
                % antireflecting front surface
  end

  properties (Dependent = true)
    LegendString;
  end


  methods    
    function sctf = DoublePass(materialData, thickness, name)
      if nargin == 2 
        sctf.MaterialData = materialData;
        sctf.Thickness = thickness; 
        sctf.Name = [num2str(thickness), ' nm'];
      else
        sctf.MaterialData = materialData;
        sctf.Thickness = thickness; 
        sctf.Name = name;
      end
      sctf.AbsorptionResults = sctf.calc_absorption_results;
    end

    
    function legendString = get.LegendString(sctf)
      legendString = ['Double Pass ', num2str(sctf.Thickness), ' nm'];
    end

    
    function absorptionResults = calc_absorption_results(sctf)
      % assuming the front surface is perfectly antireflecting and the 
      % back surface is perfectly reflecting
      data = 1 - exp(-2.*sctf.MaterialData.OpticalProperties.Alpha.*sctf.Thickness);
      %data(sctf.MaterialData.OpticalProperties.Energy < sctf.MaterialData.BandGap) = 0;
%      sc.Structure.AbsorptionResults.Data(...
%          sc.Structure.AbsorptionResults.Energy < ...
%          sc.Structure.MaterialData.BandGap) = 0

      absorptionResults = Monitor('Absorption',...
        sctf.MaterialData.OpticalProperties.Frequency(length(data):-1:1)', data(length(data):-1:1)');
    end
  end
  
  methods(Static) 

    function [sr] = create_array(thicknesses, materialData, name)
      sr = DoublePass.empty(length(thicknesses), 0);     
      if nargin == 2
        for i = 1:length(thicknesses)
          sr(i) = DoublePass(materialData, thicknesses(i));
        end
      else
        for i = 1:variableArray.NumValues
          sr(i) = DoublePass(materialData, thicknesses(i), name);
        end
      end
    end

%     function [scArray] = create_thin_film_array(solarSpectrum, materialData, thicknessArray)
% 
%       scArray = SolarCellArray(length(thicknessArray), thicknessArray, 'Thickness (nm)');
%       for i = 1:length(thicknessArray)
%         scArray.SolarCell(i) = SolarCell(solarSpectrum, ThinFilm(materialData, thicknessArray(i)));
%       end
%     end
    test()
    
    test2()

  end
  
end


