classdef FDTDSimulationResults < SimulationResults
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
    %   SS;
  end

  properties(Hidden)
    IndependentVariableType; % either frequency or wavelength for reading in Monitor files
  end
  
  properties (Dependent = true)
    Name;    
  end
  
  methods
    
    function sr = FDTDSimulationResults(filename, independentVariableType, percent)
      % Constructor
      if nargin == 1 && strcmp(filename,'')
        sr.Filename = '';
      else
        if nargin == 1
          percent = 0;
          sr.Filename = filename;
          sr.IndependentVariableType = 'Frequency';
        elseif nargin == 2 
          sr.Filename = filename;
          sr.IndependentVariableType = independentVariableType;
          percent = 0;
        elseif nargin == 3
          sr.Filename = filename;
          sr.IndependentVariableType = independentVariableType;
        end
        sr.ReflectionResults = sr.calc_reflection_results;
        sr.TransmissionResults = sr.calc_transmission_results(sr.ReflectionResults.Frequency);
        sr.AbsorptionResults = sr.calc_absorption_results(percent);
      end
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
        
    
    
    function transmissionResults = calc_transmission_results(sr, frequency)
      file = dir([sr.Filename, 'T*']); 
      if isempty(file) 
        disp(['No Transmission found for ', sr.Filename, '; Transmission = 0']);        
        transmissionResults = Monitor('Transmission', ...
          frequency, zeros(1, length(frequency)));
      else
        filename = file.name;
        [frequency, data] = ...
          sr.read_monitor_results(filename, sr.IndependentVariableType);
        transmissionResults = Monitor('Transmission', frequency, data);       
      end
    end
    
    
    
    
%     function ultimateEfficiency = get.UltimateEfficiency(sr)
%       ultimateEfficiency = sr.CalculateUltimateEfficiency(sr.SS, sr.MD.BandGap,...
%         sr.AbsorptionResults);
%     end
  end
  
  methods(Static)
    
    test;
    
    test2;
    
    test3;
    
    function sr = create_empty_simulation_results(wavelengths)
      % Constructor
      sr = FDTDSimulationResults('');
      sr.ReflectionResults = Monitor('Reflection', ...
        Photon.convert_wavelength_to_frequency(wavelengths), 100*ones(1, length(wavelengths)));
      sr.TransmissionResults = Monitor('Transmission', ...
        Photon.convert_wavelength_to_frequency(wavelengths), zeros(1, length(wavelengths)));
      sr.AbsorptionResults = sr.calc_absorption_results;
    end
    
    
    function sr = create_array(filenames, independentVariableType)
      ind = strfind(filenames(1), 'Theta');
      if ~isempty(ind{:})
        display('Warning: use FDTDSimulationResultsArray.create for angle dependence');
      end
      if nargin == 1
        independentVariableType = 'Frequency';
      end
      sr = FDTDSimulationResults.empty(length(filenames), 0);
      for i = 1:length(filenames)
        sr(i) = FDTDSimulationResults(filenames{i}, independentVariableType);
      end
    end
    
    function [frequency, data] = read_monitor_results(filename, independentVariableType)
      if ~exist(filename, 'file')
        filename = [filename, '.txt'];
      end
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
        FDTDSimulationResults.read_monitor_results(filenameRead, ...
        independentVariableType);
      fid = fopen([filename, 'Reflection.txt'], 'w');
      fprintf(fid, num2str(frequency));
      fprintf(fid, '\n');
      fprintf(fid, num2str(1-data));
      sr = FDTDSimulationResults(filename, 'frequency');
      %, independentVariableType);
      
      %filename; 
      %sr.ReflectionResults = Monitor('Reflection', frequency, 1-data);
      %sr.Filename = filename;
      %sr.TransmissionResults = sr.calc_transmission_results(sr.ReflectionResults.Frequency);
      sr.AbsorptionResults = sr.calc_absorption_results;
    end
   
    
  end
  
      
end
