classdef Monitor < handle
% MONITOR class for simulation monitor results
% 
% See also 
%
%% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  properties
    Type;       % string, which must be reflection, transmission, or absorption 
    MonitorPhoton;
    Data;       % vector from 0 to 1  
  end
  
  properties (Dependent = true)
    DataPercent; % vector from 0 to 100
    Frequency;  % vector in Hz
    Energy; % eV
    Wavelength; % nm 
    NumFrequency;
  end
  
  methods
    function obj = Monitor(type, frequency, data)
      if nargin > 0
        if (size(frequency)== 1) ~= (size(data) ==1)
          data = data';
        end
  
        
        obj.Type = type;
        if size(frequency, 2) == 1
          obj.MonitorPhoton = ...
            Photon(Photon.ConvertFrequencyToWavelength(frequency'));
          obj.Data = data';
        else
          %[frequency, ind] = sort(frequency);
          %obj.MonitorPhoton = ...
%            Photon(Photon.convert_frequency_to_wavelength(frequency));
          %obj.Data = data;
          
          [frequency, ind] = sort(frequency);
          %[frequency, ind] = sort(frequency);
          obj.MonitorPhoton = ...
            Photon(Photon.convert_frequency_to_wavelength(frequency));
          obj.Data = data(ind);
        end
      else
        obj.MonitorPhoton = ...
            Photon();
      end
    end
        
    function set.Type(obj,type)
      Monitor.check_monitor_type(type);
      obj.Type = type;
    end

    function dataPercent = get.DataPercent(obj)
      dataPercent = obj.Data*100;
    end
    
    function numFrequency = get.NumFrequency(obj)
      [numFrequency] = length(obj.Frequency);
    end
    
    function frequency = get.Frequency(obj)
      [frequency] = obj.MonitorPhoton.Frequency;
    end
    
    function energy = get.Energy(obj)
      [energy] = obj.MonitorPhoton.Energy;
    end

    function wavelength = get.Wavelength(obj)
      [wavelength] = obj.MonitorPhoton.Wavelength;
    end
    
    function set.Energy(obj, energy)
      obj.MonitorPhoton.Energy = energy;
    end

    function set.Frequency(obj, frequency)
      obj.MonitorPhoton.Frequency = frequency;
    end

    function set.Wavelength(obj, wavelength)
      obj.MonitorPhoton.Wavelength = wavelength;
    end
    
  end  
  methods(Static)  
    
    function obj = create_with_wavelength(type, wavelength, data)
      obj = Monitor(type, Photon.convert_wavelength_to_frequency(wavelength), data);
    end

    function check_monitor_type(type)
      if ~(strcmpi(type,'reflection') || ...
          strcmpi(type,'transmission') || ...
          strcmpi(type,'absorption') || ...
          strcmpi(type, 'current') || ...
          strcmpi(type, 'transmissionTotal') || ...
          strcmpi(type, 'transmissionDirect') || ...
          strcmpi(type, 'haze'))
        error(['Type must be reflection, transmission, absorption, current,'...
          'transmissionTotal, transmissionDirect', 'haze']);
      end
    end
    
    test()
    
    test2()
    

  end

  
  
end

