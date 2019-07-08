function rejection_ratio = calculate_rejection_ratio( sr,rejection_cutoff )
%CALCULATE_REJECTION_RATIO Summary of this function goes here
%   Calculte the rejection ratio for optical filter in dB
%   Tongchuan Gao
%   2013

[pks,locs] = findpeaks(sr.TransmissionResults.Data);
% find the highest peak
pk_max = max(pks);
% calculate the mean transmission in rejection range
rejectionTransmission = mean(sr.TransmissionResults.Data(find(sr.TransmissionResults.Wavelength > rejection_cutoff)));
% calculate rejection ratio in dB
rejection_ratio = 10*log10(pk_max / rejectionTransmission);




end

