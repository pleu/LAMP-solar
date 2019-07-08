classdef FrequencyTab < handle
  %FREQUENCY Summary of this class goes here
  %   Detailed explanation goes here

  properties
    SourceType;
  end

  properties(Dependent)
    WavelengthMin;
    WavelengthMax;
    WavelengthCenter;
    WavelengthSpan;       % in microns
    FrequencyMin;
    FrequencyMax;
    FrequencyCenter;
    FrequencySpan;
    
    Frequency;            % in THz
%    Pulselength;        % in fs
%     offset;         not sure how to relate with wavelength/frequency
    Bandwidth;            % in THz
  end

  
   properties(Access = 'private')
     WavelengthCoordinates; % Coordinates object
     FrequencyCoordinates; % Coordinates object
   end
  
  methods
    function obj = FrequencyTab(varargin)
      if nargin == 0
        obj.WavelengthCoordinates = Coordinates();
        obj.FrequencyCoordinates = Coordinates();
        obj.SourceType = 'broadband source';
      end
    end
    
    function wavelengthCenter = get.WavelengthCenter(obj)
      wavelengthCenter = obj.WavelengthCoordinates.Center;
    end

    function wavelengthSpan = get.WavelengthSpan(obj)
      wavelengthSpan = obj.WavelengthCoordinates.Span;
    end
    
    function wavelengthMin = get.WavelengthMin(obj)
      wavelengthMin = obj.WavelengthCoordinates.Min;
    end

    function wavelengthMax = get.WavelengthMax(obj)
      wavelengthMax = obj.WavelengthCoordinates.Max;
    end 
    
    function frequencyCenter = get.FrequencyCenter(obj)
      frequencyCenter = obj.FrequencyCoordinates.Center;
    end

    function frequencySpan = get.FrequencySpan(obj)
      frequencySpan = obj.FrequencyCoordinates.Span;
    end

    function frequencyMin = get.FrequencyMin(obj)
      frequencyMin = obj.FrequencyCoordinates.Min;
    end

    function frequencyMax = get.FrequencyMax(obj)
      frequencyMax = obj.FrequencyCoordinates.Max;
    end
    
    function frequency = get.Frequency(obj)
        frequency = obj.FrequencyCoordinates.Center;
    end
    
    
    function bandwidth = get.Bandwidth(obj)
        bandwidth = obj.FrequencyCoordinates.Span;
    end

    function set.SourceType(obj, sourceType)
      options = {'standard source', 'broadband source'};
      obj.SourceType = set_value_from_list(options, sourceType);
    end
    
    function set.WavelengthCenter(obj, wavelengthCenter)
      obj.WavelengthCoordinates.Center = wavelengthCenter;
    end
    
    function set.WavelengthSpan(obj, wavelengthSpan)
      obj.WavelengthCoordinates.Span = wavelengthSpan;
    end
 
    function set.WavelengthMin(obj, wavelengthMin)
      obj.WavelengthCoordinates.Min = wavelengthMin;
      obj.FrequencyCoordinates.Max = Photon.ConvertWavelengthToFrequency(wavelengthMin*...
          Constants.UnitConversions.MicronstoNM)*Constants.UnitConversions.HztoTHz;
    end
 
    function set.WavelengthMax(obj, wavelengthMax)
      obj.WavelengthCoordinates.Max = wavelengthMax;
      obj.FrequencyCoordinates.Min = Photon.ConvertWavelengthToFrequency(wavelengthMax*...
          Constants.UnitConversions.MicronstoNM)*Constants.UnitConversions.HztoTHz;      
    end

    
    function set.FrequencyCenter(obj, frequencyCenter)
      obj.FrequencyCoordinates.Center = frequencyCenter;
    end
    
    function set.FrequencySpan(obj, frequencySpan)
      obj.FrequencyCoordinates.Span = frequencySpan;
    end
 
    function set.FrequencyMin(obj, frequencyMin)
      obj.FrequencyCoordinates.Min = frequencyMin;
      obj.WavelengthCoordinates.Max = Photon.ConvertFrequencyToWavelength(frequencyMin*...
          Constants.UnitConversions.THztoHz)*Constants.UnitConversions.NMtoMicrons;
    end
 
    function set.FrequencyMax(obj, frequencyMax)
      obj.FrequencyCoordinates.Max = frequencyMax;
      obj.WavelengthCoordinates.Min = Photon.ConvertFrequencyToWavelength(frequencyMax*...
          Constants.UnitConversions.THztoHz)*Constants.UnitConversions.NMtoMicrons;
    end
    
    function set.Frequency(obj, frequency)
        obj.FrequencyCoordinates.Center = frequency;
    end
    
    function set.Bandwidth(obj, bandwidth)
        obj.FrequencyCoordinates.Span = bandwidth;
    end    
    

    
  end
  
  
  
  methods(Static)
    test();
  end
  
end

