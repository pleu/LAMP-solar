classdef Lambertian < Absorber
% Lambertian class for solar cell
% Thin film with Lambertian scattering to increase the path length
%
% See also ThinFilm
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
    function sctf = Lambertian(materialData, thickness, theta, name)
      if nargin == 2 
        sctf.MaterialData = materialData;
        sctf.Thickness = thickness; 
        sctf.AbsorptionResults = sctf.calcAbsorptionResults;
        sctf.Name = [num2str(thickness), ' nm with light trapping'];
      elseif nargin == 3
        sctf.MaterialData = materialData;
        sctf.Thickness = thickness; 
        sctf.AbsorptionResults = sctf.calcAbsorptionResults(theta);
        sctf.Name = [num2str(thickness), ' nm with light trapping'];
      else
        sctf.MaterialData = materialData;
        sctf.Thickness = thickness; 
        sctf.AbsorptionResults = sctf.calcAbsorptionResults;
        sctf.Name = name;        
      end
    end
    
    function legendString = get.LegendString(sctf)
      legendString = ['Lambertian ', num2str(sctf.Thickness), ' nm'];
    end

    function absorptionResults = calcAbsorptionResults(sctf, theta)
      if nargin == 1
        theta = pi/2;
      end
      % assuming the surfaces are Lambertian scatterers
%       data = sctf.MaterialData.OpticalProperties.Alpha./...
%         (sctf.MaterialData.OpticalProperties.Alpha +...
%         1./(4*sctf.MaterialData.OpticalProperties.N.^2*sctf.Thickness));
      data = sctf.MaterialData.OpticalProperties.Alpha./...
        (sctf.MaterialData.OpticalProperties.Alpha +...
        (sin(theta))^2./(4*sctf.MaterialData.OpticalProperties.N.^2*sctf.Thickness));
%       data = 1- 1./...
%         (1 +...
%         ...
%         (4*sctf.MaterialData.OpticalProperties.Alpha.*sctf.MaterialData.OpticalProperties.N.^2*sctf.Thickness));
%       
      data(sctf.MaterialData.OpticalProperties.Energy < sctf.MaterialData.BandGap) = 0;
      absorptionResults = Monitor('Absorption',...
        sctf.MaterialData.OpticalProperties.Frequency(length(data):-1:1)', data(length(data):-1:1)');
    end
  end

  methods(Static)
    function [sr] = create_array(thicknesses, materialData, thetaE, name)
      sr = Lambertian.empty(length(thicknesses), 0);     
      if nargin == 2
        for i = 1:length(thicknesses)
          sr(i) = Lambertian(materialData, thicknesses(i));
        end
      elseif nargin == 3
        for i = 1:length(thicknesses)
          sr(i) = Lambertian(materialData, thicknesses(i), thetaE);
        end
      else
        for i = 1:length(thicknesses)
          sr(i) = Lambertian(materialData, thicknesses(i), thetaE, name);
        end
      end
    end

    test()
%     function [scArray] = create_Lambertian_array(solarSpectrum, materialData, thicknessArray)
%       scArray = SolarCellArray(length(thicknessArray), thicknessArray, 'Thickness (nm)');
%       for i = 1:length(thicknessArray)
%         scArray.SolarCell(i) = SolarCell(solarSpectrum, Lambertian(materialData, thicknessArray(i)));
%       end
%     end
  end

end

