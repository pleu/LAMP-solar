function [data] = query_monitor_data_at_wavelength(obj, wavelength)
%QUERY_MONITOR_DATA Summary of this function goes here
%   Detailed explanation goes here
data = interp1(obj.Wavelength, obj.Data, wavelength);
end

