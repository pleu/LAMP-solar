classdef OpticalFilter < Absorber & TransparentStructureType
% FDTDSIMULATIONRESULTS class for FDTD Simulation Results
% 
% FDTDSIMULATIONRESULTS(filename) reads in files from FDTDD Simulation
% 
% FDTDSIMULATIONRESULTS(filename, independentVariableType) reads in files 
% from FDTDD Simulation where independentVariableType is either 
% 'Frequency' or 'Wavelength'; 'Frequency' by default
% 
% 
% Input
% Filename - Filename of results
% IndependentVariableType - either Frequency (default) or Wavelength
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh
  properties
    Filename;
    ReflectionResults;    % Monitor object
    TransmissionResults;  % Monitor object
    AbsorptionResults;    % Monitor object; same as external quantum efficiency  
    %   SS;
  end

  properties(Hidden)
    IndependentVariableType; % either frequency or wavelength for reading in Monitor files
  end
  
  properties (Dependent = true)
    Name;    
  end
  
  methods
    
    function sr = OpticalFilter(filename, independentVariableType)
      % Constructor
      if nargin == 1
        sr.Filename = filename;
        sr.IndependentVariableType = 'Frequency';
      elseif nargin == 2
        sr.Filename = filename;
        sr.IndependentVariableType = independentVariableType;
      end
      sr.ReflectionResults = sr.calc_reflection_results;
      sr.TransmissionResults = sr.calc_transmission_results(sr.ReflectionResults.Frequency);
      sr.AbsorptionResults = sr.calc_absorption_results;
    end
    
    function obj = set.IndependentVariableType(obj,independentVariableType)
      if ~(strcmpi(independentVariableType,'Frequency') || ...
          strcmpi(independentVariableType,'Wavelength'))
        error('Independent variable must be frequency or wavelength');
      end
      obj.IndependentVariableType = independentVariableType;
    end

    
%     function currentSC = get.CurrentSC(sr)
%       if max(sr.AbsorptionResults.Energy) < max(sr.SS.Energy)
%         absorptionInterp = interp1(sr.AbsorptionResults.Energy, ...
%           sr.AbsorptionResults.Data, sr.SS.Energy,'linear','extrap'); 
%         disp('PLEASE CHECK THE FREQUENCY RANGE OF YOUR SIMULATION!');
%       elseif min(sr.AbsorptionResults.Energy) > min(sr.SS.Energy)
%         absorptionInterp = interp1(sr.AbsorptionResults.Energy, ...
%           sr.AbsorptionResults.Data, sr.SS.Energy,'linear','extrap'); 
%         disp('PLEASE CHECK THE FREQUENCY RANGE OF YOUR SIMULATION!');
%       else
%         absorptionInterp = interp1(sr.AbsorptionResults.Energy, ...
%           sr.AbsorptionResults.Data, sr.SS.Energy);
%       end
%       currentSC = Constants.LightConstants.Q * ...
%         trapz(sr.SS.Energy, sr.SS.PhotonFlux.*absorptionInterp);
%     end

    function name = get.Name(sr)
      name = sr.Filename;
    end
        
    function reflectionResults = calc_reflection_results(sr)
      filename = [sr.Filename, 'Reflection.txt'];
      if ~exist(filename, 'file')
        filename = [sr.Filename, 'Re'];
      end
      [frequency, data] = ...
        sr.read_monitor_results(filename, ...
        sr.IndependentVariableType);
      reflectionResults = Monitor('Reflection', frequency, data);
    end
    
    function transmissionResults = calc_transmission_results(sr, frequency)
      filename = [sr.Filename, 'Transmission.txt'];
      if ~exist(filename, 'file')
        filename = [sr.Filename, 'Trans'];
      end
      if ~exist(filename, 'file')
        disp(['No Transmission found for ', filename, '; Transmission = 0']);        
        transmissionResults = Monitor('Transmission', ...
          frequency, zeros(1, length(frequency)));
      else
        [frequency, data] = ...
        sr.read_monitor_results(filename, ...
        sr.IndependentVariableType);
        transmissionResults = Monitor('Transmission', frequency, data);       
      end
    end
    
    
    function absorptionResults = calc_absorption_results(sr)
      % This is written in case frequencies are different
      frequency = sr.ReflectionResults.Frequency;
      transmission = interp1(sr.TransmissionResults.Frequency,...
        sr.TransmissionResults.Data, frequency, 'linear', 'extrap');
      data = 1 - sr.ReflectionResults.Data - transmission; 
      absorptionResults = Monitor('Absorption', frequency, data);
    end
    
%     function ultimateEfficiency = get.UltimateEfficiency(sr)
%       ultimateEfficiency = sr.CalculateUltimateEfficiency(sr.SS, sr.MD.BandGap,...
%         sr.AbsorptionResults);
%     end
  end
  
  methods(Static)
    test;
    
    function sr = create_array(filenames, independentVariableType)
      if nargin == 2
        independentVariableType = 'Frequency';
      end
      sr = OpticalFilter.empty(length(filenames), 0);
      for i = 1:length(filenames)
        sr(i) = OpticalFilter(filenames{i}, independentVariableType);
      end
    end
    
    function [frequency, data] = read_monitor_results(filename, independentVariableType)
      output = load(filename);
      if size(output, 2) == 2
        output = output'; 
      end
      if strcmpi(independentVariableType,'Frequency')
        frequency = output(1, :);
        data = output(2, :);
      else
        wavelength = output(1, :); % assume nm 
        frequency = Constants.LightConstants.C./wavelength*...
          Constants.UnitConversions.MtoNM; 
        data = output(2, :);
      end
    end
    
    function [sr] = read_absorption_file(filename, independentVariableType)
      % this creates an FDTDSimulationResults object by reading in an absorption file 
      % the transmission is set to 0 and the reflection is set to 1 - A
      if ~exist(filename, 'file')
        filenameRead = [filename, '.txt'];
      else
        filenameRead = filename;
      end
      [frequency, data] = ...
        OpticalFilter.read_monitor_results(filenameRead, ...
        independentVariableType);
      fid = fopen([filename, 'Reflection.txt'], 'w');
      fprintf(fid, num2str(frequency));
      fprintf(fid, '\n');
      fprintf(fid, num2str(1-data));
      sr = OpticalFilter(filename, independentVariableType);
      
      %filename; 
      %sr.ReflectionResults = Monitor('Reflection', frequency, 1-data);
      %sr.Filename = filename;
      %sr.TransmissionResults = sr.calc_transmission_results(sr.ReflectionResults.Frequency);
      %sr.AbsorptionResults = sr.calc_absorption_results;
    end

    
  end
      
end
