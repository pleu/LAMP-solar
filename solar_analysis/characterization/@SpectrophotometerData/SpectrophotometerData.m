classdef SpectrophotometerData
  %SPECTROPHOTOMETER Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Filename;
    TransmissionTotal;  % Monitor object
    TransmissionDirect;  % Monitor object
    
    Reflection;    % Monitor object
    AbsorptionResults;    % Monitor object
  end
    
  properties (Dependent = true)
    Haze;   % Monitor object
  end
  
  methods
    function df = SpectrophotometerData(filename)
      % Type is diffusive or specular
      % diffusive is total
      % specular is direct
      %       if nargin == 1
      %         types = 'Transmission';
      %       end
      if nargin == 1 
        df.Filename = filename;
        df.TransmissionTotal = df.calc_transmission_total_results();
        df.TransmissionDirect = df.calc_transmission_direct_results();
        df.Reflection = df.calc_reflection_results();
        df.AbsorptionResults = df.calc_absorption_results();
      end
    end
    
    function reflection = calc_reflection_results(sr)
      % files must be named with T, but no spec after
      file = dir([sr.Filename, 'R*']);
      if isempty(file) 
        disp(['No Reflection found for ', sr.Filename, '.']);        
        reflection = Monitor.empty;
      elseif length(file) > 1
        error('More than one transmission file found');
        file
      else
        reflection = sr.read_spectrophotometer_file_into_monitor(file.name, 'Reflection');
      end
    end
    
    function [absorptionResults] = calc_absorption_results(sr)
      if ~isempty(sr.Reflection) && ~isempty(sr.TransmissionTotal)
        % This is written in case frequencies are different
        frequency = sr.Reflection.Frequency;
        if length(frequency) > 1
          transmission = interp1(sr.TransmissionTotal.Frequency,...
            sr.TransmissionTotal.Data, frequency, 'linear', 'extrap');
        else
          transmission = sr.TransmissionTotal.Data;
        end
        data = 1 - sr.Reflection.Data - transmission;
        absorptionResults = Monitor('Absorption', frequency, data);
      else
        absorptionResults = Monitor.empty;
      end
    end


    
    function transmissionResults = calc_transmission_total_results(sr)
      % files must be named with T, but no spec after
      file = dir([sr.Filename, 'T*']);
      indRemove = [];
      for i = 1:length(file)
        k = strfind(file(i).name, 'Tdirect');
        if ~isempty(k) 
          indRemove = [indRemove i];
        end
      end
      file(indRemove) = [];

      if isempty(file) 
        disp(['No Transmission found for ', sr.Filename, '; Transmission = 0']);        
        transmissionResults = Monitor.empty;
      elseif length(file) > 1
        error('More than one transmission file found');
        file
      else
        transmissionResults = sr.read_spectrophotometer_file_into_monitor(file.name, 'Transmission');
      end
    end
    

    function transmissionResults = calc_transmission_direct_results(sr)
      % files must be named with T, but no spec after
      file = dir([sr.Filename, 'Tdirect*']);
      if isempty(file) 
        disp(['No Direct Transmission found for ', sr.Filename, '.']);        
        transmissionResults = Monitor.empty;
      elseif length(file) > 1
        error('More than one transmission file found');
        file
      else
        transmissionResults = sr.read_spectrophotometer_file_into_monitor(file.name, 'TransmissionDirect');
      end
    end
    
    
% 
% 
% percentToNumber = 0.01; % from percent to number from 0 to 1
%       
%       
%       if nargin > 0
%         numHeaderLines = 1;
%         
%         if ~iscell(filenames) % assume is single filename 
%           df.Filenames = filenames;
%           data = csvread(filenames, numHeaderLines, 0);
%           df.Monitors = Monitor(types, Photon.convert_wavelength_to_frequency(data(:, 1)), data(:, 2)*percentToNumber);
%         else
%           df.Monitors = Monitor.empty(length(filenames), 0);
%           if ~iscell(types)
%             [temp{1:length(filenames)}] = deal(types);
%             types = temp;
%           end
%           for i = 1:length(filenames)
%             data = csvread(filenames{i}, numHeaderLines, 0);
%             df.Filenames = filenames;
%             df.Monitors(i) = Monitor(types{i}, Photon.convert_wavelength_to_frequency(data(:, 1)), data(:, 2)*percentToNumber);
%           end
% 
%         end
%       
%       end
%     end
    
    function haze = get.Haze(sd)
      %ind2sub(size({sd.Monitors.Type}), strcmp('transmissionSpecular', {sd.Monitors.Type}));
      %wavelengths = Monitors(indDiffusive).
      
      frequencies = sd.TransmissionTotal.Frequency;
      transmissionTotal = sd.TransmissionTotal.Data;
      
      transmissionDirect = interp1(sd.TransmissionDirect.Frequency, sd.TransmissionDirect.Data, frequencies)';
      if (size(transmissionDirect)== 1) ~= (size(transmissionTotal) ==1)
        transmissionDirect = transmissionDirect';
      end
      
      haze = (transmissionTotal - transmissionDirect)./transmissionTotal;
      
      haze = Monitor('Haze', frequencies, haze);
    end
    
    
    function monObj = get_monitor_array(obj, monitorType)
      
      Monitor.check_monitor_type(monitorType);
      monObj = Monitor.empty(length(obj), 0);
      
      for i = 1:length(obj)
        if strcmpi(monitorType, 'transmissionTotal')
          monObj(i) = obj(i).TransmissionTotal;
        elseif strcmpi(monitorType, 'transmissionDirect')
          monObj(i) = obj(i).TransmissionDirect;
        elseif strcmpi(monitorType, 'haze')
          monObj(i) = obj(i).Haze;
        end
      end
    end
    
  end
  
  methods(Static) 
    function df = read_array(filenames)
      numFilenames = length(filenames);
      df = SpectrophotometerData.empty(numFilenames, 0);
      for i = 1:length(filenames)
        df(i) = SpectrophotometerData(filenames{i});
      end
    end
 
    
    function monitor = read_spectrophotometer_file_into_monitor(filename, type)
      percentToNumber = 0.01; % from percent to number from 0 to 1
      numHeaderLines = 1;  
      data = csvread(filename, numHeaderLines, 0);
      monitor = Monitor(type, Photon.convert_wavelength_to_frequency(data(:, 1)), data(:, 2)*percentToNumber);
    end      
    
    test()
    test2()
    test3()
  end
  
end

