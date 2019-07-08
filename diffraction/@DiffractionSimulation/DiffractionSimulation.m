classdef DiffractionSimulation < handle
  %DIFFRACTIONSIMULATION Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Structure;  % each structure will have its own 
    LightSource;
    VariableArray;
    DiffractionPattern;  % number of rows is number of wavelengths; 
                         % number of columns is number of structures                     
  end
  
  properties(Dependent)
    Dimensions;
    NumWavelengths;
    NumStructures;
    HazeAngle;
    HazeMode;
    NumModes;
    Transparency;
  end

  
  methods
    function obj = DiffractionSimulation(structure, lightsource, variableArray)
      if nargin == 2
        obj.Structure = structure;
        obj.LightSource = lightsource;
      elseif nargin == 3
        obj.Structure = structure;
        obj.LightSource = lightsource;
        obj.VariableArray = variableArray;
      end
      obj.DiffractionPattern = obj.calc_diffraction_patterns;
    end

    function [dimensions] = get.Dimensions(obj)
      for i = 1:obj.NumStructures
        if obj.Structure(i).Dimensions ~= obj.Structure(1).Dimensions
          error('The dimensions of all the structures must be the same')
        end
      end
      dimensions = obj.Structure(1).Dimensions;
    end
    
    function [numStructures] = get.NumStructures(obj)
      numStructures = numel(obj.Structure);
    end
    
    function [numWavelengths] = get.NumWavelengths(obj)
      numWavelengths = obj.LightSource.NumWavelength;
    end
    
    function [transparency]= get.Transparency(obj)
      transparency = [obj.Structure.Transparency];
    end
    
    function [numModes] = get.NumModes(obj)
      %obj.LightSource.Energy
      if obj.NumWavelengths == 1
        numModes = [obj.DiffractionPattern.NumModes];
      else
        %hazeModeIntegrated = [obj.DiffractionPattern.HazeMode];
        %hazeModeIntegrated = reshape(hazeModeIntegrated, obj.NumStructures,
        %         [energySort, ind] = sort(obj.LightSource.Energy);
        numModes = reshape([obj.DiffractionPattern.NumModes], obj.NumWavelengths, obj.NumStructures);
%         photonFlux = obj.LightSource.PhotonFlux(ind)'*ones(1, obj.NumStructures);
%         hazeModeIntegrated = trapz(energySort, ...
%           hazeMode(ind, :).*photonFlux)/obj.LightSource.NumPhotons;
      end
%       hazeAngleIntegrated = SolarCell.calculate_integrated_data(obj.LightSource,...
%         obj.LightSource.Energy,...
%         obj.DiffractionPattern.HazeAngle);
    end
    
    function [hazeMode] = get.HazeMode(obj)
      %obj.LightSource.Energy
      if obj.NumWavelengths == 1
        hazeMode = [obj.DiffractionPattern.HazeMode];
      else
        %hazeModeIntegrated = [obj.DiffractionPattern.HazeMode];
        %hazeModeIntegrated = reshape(hazeModeIntegrated, obj.NumStructures,
        %         [energySort, ind] = sort(obj.LightSource.Energy);
        hazeMode = reshape([obj.DiffractionPattern.HazeMode], obj.NumWavelengths, obj.NumStructures);
%         photonFlux = obj.LightSource.PhotonFlux(ind)'*ones(1, obj.NumStructures);
%         hazeModeIntegrated = trapz(energySort, ...
%           hazeMode(ind, :).*photonFlux)/obj.LightSource.NumPhotons;
      end
%       hazeAngleIntegrated = SolarCell.calculate_integrated_data(obj.LightSource,...
%         obj.LightSource.Energy,...
%         obj.DiffractionPattern.HazeAngle);
    end

    
    function [hazeAngle] = get.HazeAngle(obj)
      %obj.LightSource.Energy
      if length(obj.LightSource.Energy) == 1
        hazeAngle = [obj.DiffractionPattern.HazeAngle];
      else
        %[energySort, ind] = sort(obj.LightSource.Energy);
        hazeAngle = reshape([obj.DiffractionPattern.HazeAngle], obj.NumWavelengths, obj.NumStructures);
        %photonFlux = obj.LightSource.PhotonFlux(ind)'*ones(1, obj.NumStructures);
        %hazeAngleIntegrated = trapz(energySort, ...
%          hazeAngle(ind, :).*photonFlux)/obj.LightSource.NumPhotons;      
        %       hazeAngleIntegrated = SolarCell.calculate_integrated_data(obj.LightSource,...
        %         obj.LightSource.Energy,...
        %         obj.DiffractionPattern.HazeAngle);
      end
    end
  
    function [diffractionPattern] = calc_diffraction_patterns(obj)
      if obj.Dimensions == 1
        diffractionPattern(obj.NumWavelengths, obj.NumStructures) = OneDDiffractionPattern;
      elseif obj.Dimensions == 2
        diffractionPattern(obj.NumWavelengths, obj.NumStructures) = TwoDDiffractionPattern;
      end

      for i = 1:obj.NumWavelengths
        for j = 1:obj.NumStructures
          diffractionPattern(i, j) = obj.Structure(j).calc_diffraction_pattern(obj.LightSource.Wavelength(i));
        end
      end

%      [obj] = calc_diffraction_patterns(obj)
    end
    
    function set.DiffractionPattern(obj, value)
      if isa(value,'OneDDiffractionPattern') || isa(value,'TwoDDiffractionPattern')  % will probably change to broader class later
        obj.DiffractionPattern = value;
      else
        error('Structure should be of class OneDDiffractionPattern');
      end
    end
    
%     function set.Structure(obj, value)
%       if isa(value,'DiffractionStructure')  % will probably change to broader class later
%         obj.Structure = value;
%       else
%         error('Structure should be of class DiffractionStructure');
%       end
%     end
    
    function set.LightSource(obj, value)
      if isa(value,'SolarSpectrum')
        obj.LightSource = value;
      else
        error('LightSource should be of class SolarSpectrum');
      end
    end
    


  end
  
  methods(Static)
    test()
    test2()
    test3()
    test4()
    test5()
  end
  
end

