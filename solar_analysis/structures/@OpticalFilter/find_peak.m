function [pk_max,pk_wavelength] = find_peak( sr )
%FIND_PEAK Summary of this function goes here
%   Find the peak for optical filter
%   Tongchuan Gao
%   2013

[pks,locs] = findpeaks(sr.TransmissionResults.Data);
% find the highest peak
pk_max = max(pks);
% locate the highest peak
locs = find(sr.TransmissionResults.Data == pk_max);
pk_wavelength = sr.TransmissionResults.Wavelength(locs);

end

