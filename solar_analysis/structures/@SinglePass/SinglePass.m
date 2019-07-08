classdef SinglePass < Absorber
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

  methods    
    function sctf = SinglePass(materialData, thickness, name)
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

    function absorptionResults = calc_absorption_results(sctf)
      % assuming the front surface is perfectly antireflecting and the 
      % back surface is perfectly reflecting
      data = 1 - exp(-1.*sctf.MaterialData.OpticalProperties.Alpha.*sctf.Thickness);
      data(sctf.MaterialData.OpticalProperties.Energy < sctf.MaterialData.BandGap) = 0;
      %      sc.Structure.AbsorptionResults.Data(...
      %          sc.Structure.AbsorptionResults.Energy < ...
      %          sc.Structure.MaterialData.BandGap) = 0
      
      [frequency, ind] = sort(sctf.MaterialData.OpticalProperties.Frequency);
      absorptionResults = Monitor('Absorption',...
        frequency, data(ind));
    end
  end
  
  methods(Static) 

    function [sr] = create_single_pass_array(variableArray, materialData, name)
      sr = SinglePass.empty(variableArray.NumValues, 0);     
      if nargin == 2
        for i = 1:variableArray.NumValues
          sr(i) = SinglePass(materialData, variableArray.Values(i));
        end
      else
        for i = 1:variableArray.NumValues
          sr(i) = SinglePass(materialData, variableArray.Values(i), name);
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

  end
  
end



