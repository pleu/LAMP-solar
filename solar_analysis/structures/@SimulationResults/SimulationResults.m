classdef SimulationResults < Absorber & TransparentStructureType
  %SIMULATIONRESULTS Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    ReflectionResults;    % Monitor object
    TransmissionResults;  % Monitor object
    AbsorptionResults;    % Monitor object; same as external quantum efficiency  
  end
  
  methods
    
    function sr = SimulationResults(wavelengths, reflectionData, transmissionData, absorptionData)
      if nargin == 1
        sr.ReflectionResults = Monitor('Reflection', ...
          Photon.convert_wavelength_to_frequency(wavelengths), zeros(length(wavelengths), 1));
        sr.TransmissionResults = Monitor('Transmission', ...
          Photon.convert_wavelength_to_frequency(wavelengths), zeros(length(wavelengths), 1));
        sr.AbsorptionResults = Monitor('Absorption', ...
          Photon.convert_wavelength_to_frequency(wavelengths), zeros(length(wavelengths), 1));
      elseif nargin == 4
        sr.ReflectionResults = Monitor.create_with_wavelength('Reflection', wavelengths, reflectionData); 
        sr.TransmissionResults = Monitor.create_with_wavelength('Transmission', wavelengths, transmissionData);
        %dataAbsorption = 1 - reflectionData - transmissionData;
        sr.AbsorptionResults = Monitor.create_with_wavelength('Absorption', wavelengths, absorptionData);
      end
    end
    
    function ma = get_monitor(sr, monitorType)
      if strcmpi(monitorType, 'Reflection')
        %multiplot_add_energy_top_axis({sr.ReflectionResults.Energy}, {{sr.ReflectionResults.Energy})
        %ma = Monitor.empty(numel(sr),0);
        %for i = 1:numel(sr)
        %  ma(i) = sr(i).ReflectionResults;
        %end
        ma = [sr.ReflectionResults];
      elseif strcmpi(monitorType, 'Transmission')
        ma = [sr.TransmissionResults];
      elseif strcmpi(monitorType, 'Absorption')
        ma = [sr.AbsorptionResults];
      end
    end
    
  end
  
  methods(Static)
    
%     
%     function sr = create_from_RCWA(wavelengths, reflectionData, transmissionData, absorptionData)
%       % Constructor
%       
%       sr.ReflectionResults = Monitor.create_with_wavelength('Reflection', wavelengths, reflectionData); 
%       sr.TransmissionResults = Monitor.create_with_wavelength('Transmission', wavelengths, transmissionData);
%       %dataAbsorption = 1 - reflectionData - transmissionData;
%       sr.AbsorptionResults = Monitor.create_with_wavelength('Absorption', wavelengths, absorptionData);
%       %sr.AbsorptionResults = MonitorWavelength('Transmission', wavelengths, data);
%     end
%     
  end
  
end

