function [transmissionSpecular, transmissionDiffusive, haze] = get_data_at_wavelength(sd, wavelength)
%GET_DATA_AT_WAVELENGTH Summary of this function goes here
%   Detailed explanation goes here



% indDiffusive = find(strcmp('transmission', {sd.Monitors.Type})==1);
% indSpecular = find(strcmp('transmissionDirect', {sd.Monitors.Type})==1);

transmissionSpecular = zeros(length(sd), 1);
transmissionDiffusive = zeros(length(sd), 1);
haze = zeros(length(sd), 1);

for i = 1:length(sd)
  transmissionSpecular(i) = interp1(sd(i).TransmissionDirect.Wavelength, sd(i).TransmissionDirect.Data, wavelength);
  transmissionDiffusive(i) = interp1(sd(i).TransmissionTotal.Wavelength, sd(i).TransmissionTotal.Data, wavelength);
  haze(i) = interp1(sd(i).Haze.Wavelength, sd(i).Haze.Data, wavelength);
end
  
end

