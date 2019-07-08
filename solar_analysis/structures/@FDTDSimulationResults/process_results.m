function [sr] = process_results(sr, type)
%PROCESS_RESULTS 
% This function makes sure all the T, R, and A have the same frequencies
% or wavelengths
% Values are obtained by linear interpolation
% 
% type = 'frequency' or 'wavelength'; 'wavelength' by default
% 
% Copyright 2012
% Paul W. Leu

  if nargin == 1
    type = 'wavelength';
  end

  if strncmp(type, 'wavelength', 1)
    minWavelength = max([min(sr.ReflectionResults.Wavelength),...
      min(sr.ReflectionResults.Wavelength)]); 
    maxWavelength = min([max(sr.ReflectionResults.Wavelength),...
      max(sr.ReflectionResults.Wavelength)]); 
    numWavelength = max([sr.ReflectionResults.NumFrequency...
      sr.ReflectionResults.NumFrequency]);
    wavelength = linspace(minWavelength, maxWavelength, numWavelength);
    sr.ReflectionResults.Data = interp1(sr.ReflectionResults.Wavelength,...
      sr.ReflectionResults.Data, wavelength);
    sr.ReflectionResults.Frequency = Photon.ConvertWavelengthToFrequency(wavelength);
    sr.TransmissionResults.Data = interp1(sr.TransmissionResults.Wavelength,...
      sr.TransmissionResults.Data, wavelength);
    sr.TransmissionResults.Frequency = Photon.ConvertWavelengthToFrequency(wavelength);
    sr.calc_absorption_results;
  else

  end

end

