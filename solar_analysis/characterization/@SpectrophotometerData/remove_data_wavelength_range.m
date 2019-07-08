function [obj] = remove_data_wavelength_range(obj, monitorType, minWavelength, maxWavelength)
% removes data between wavelength range

[monObj] = obj.get_monitor_array(monitorType);

for i = 1:length(monObj)
  [monObj(i).Wavelength, monObj(i).Data] = ...
    remove_values(monObj(i).Wavelength, minWavelength, maxWavelength, monObj(i).Data);
end
% 
% %for i = 1:length(obj)
% if strcmpi(monitorType, 'transmissionTotal')
%   obj.TransmissionTotal = monObj;
% elseif strcmpi(monitorType, 'transmissionDirect')
%   obj.TransmissionDirect = monObj;
% elseif strcmpi(monitorType, 'haze')
%   obj.Haze = monObj;
% end
% %end