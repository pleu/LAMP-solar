function op = truncate_spectrum_wavelength(op, minWavelength, maxWavelength)
% TRUNCATE_SPECTRUM_WAVELENGTH
% truncates the solar spectrum to just values between 
% minWavelength and maxWavelength
% 
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  for i = 1:size(op, 2)
    [op(i).Wavelength, op(i).N, op(i).K] = ...
      truncate(op(i).Wavelength, minWavelength, maxWavelength,...
      op(i).N, op(i).K);
  end
  
end

