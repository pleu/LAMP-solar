classdef FrequencyDomainIndexGeneral < handle & matlab.System
  %FrequencyDomainIndexGeneral Summary of this class goes here
  %   Detailed explanation goes here
  properties 
    SimulationType;  % 1: All, 2: 3D, 3: 2D z-normal
    OverrideGlobalMonitorSettings;  % check box
    UseLinearWavelengthSpacing;     % check box
    UseSourceLimits;                % check box
    FrequencyPoints;

  end
  properties (Dependent)
    WavelengthMin;
    WavelengthMax;
    WavelengthCenter;
    WavelengthSpan;       % in microns
    FrequencyMin;
    FrequencyMax;
    FrequencyCenter;
    FrequencySpan;
  end
  
  properties(Access = 'private')
    WavelengthCoordinates; % Coordinates object
    FrequencyCoordinates; % Coordinates object
  end
  
  methods(Access = protected)
    function flag = isInactivePropertyImpl(obj,propertyName)
      if getnameidx({'SimulationType', 'OverrideGlobalMonitorSettings'}, propertyName)
        flag = false;
      elseif obj.OverrideGlobalMonitorSettings
        if getnameidx({'UseSourceLimits', 'UseLinearWavelengthSpacing', 'FrequencyPoints'}, propertyName)
          flag = false;
        else
          if obj.UseSourceLimits
            flag = true;
          else
            flag = false;
          end               
        end
      else
        flag = true;
      end
    end
  end
  
  methods
    function obj = FrequencyDomainIndexGeneral(varargin)
      if nargin == 0
        % Default values
        obj.SimulationType = 'All';
        obj.OverrideGlobalMonitorSettings = 0;
        obj.UseLinearWavelengthSpacing = 0;
        obj.UseSourceLimits = 1;
        obj.FrequencyPoints = 5; 
        obj.WavelengthCoordinates = Coordinates();
        obj.FrequencyCoordinates = Coordinates();      
      end
    end
    
    
    function set.SimulationType(obj, simulationType)
      options = {'All', '3D', '2D z-normal'};
      obj.SimulationType = set_value_from_list(options, simulationType);
    end    
    
    function set.OverrideGlobalMonitorSettings(obj, overrideGlobalMonitorSettings)
      obj.OverrideGlobalMonitorSettings = set_check_box(overrideGlobalMonitorSettings);
    end   
    
    function set.UseLinearWavelengthSpacing(obj, useLinearWavelengthSpacing)
      obj.UseLinearWavelengthSpacing = set_check_box(useLinearWavelengthSpacing);
    end    

    function set.UseSourceLimits(obj, useSourceLimits)
      obj.UseSourceLimits = set_check_box(useSourceLimits);
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
    
  end
end
