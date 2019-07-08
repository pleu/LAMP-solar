function [obj] = shift_data_wavelength_range(obj, monitorType, minWavelength, maxWavelength)
%GET_DATA_AT_WAVELENGTH Summary of this function goes here
%   Detailed explanation goes here

[monObj] = obj.get_monitor_array(monitorType);

for i = 1:length(monObj)
  [monObj(i).Wavelength, monObj(i).Data] = ...
    shift_y_value(monObj(i).Wavelength, minWavelength, maxWavelength, monObj(i).Data);
end
