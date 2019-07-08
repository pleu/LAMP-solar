function [obj] = keep_data_wavelength_range(obj, monitorType, minWavelength, maxWavelength)
% removes data between wavelength range

[monObj] = obj.get_monitor_array(monitorType);

for i = 1:length(monObj)
  [monObj(i).Wavelength, monObj(i).Data] = ...
    keep_values(monObj(i).Wavelength, minWavelength, maxWavelength, monObj(i).Data);
end
% 
