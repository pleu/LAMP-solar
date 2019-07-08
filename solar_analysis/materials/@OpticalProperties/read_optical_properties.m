function [obj] = read_optical_properties(obj, filename, xVariable, xVariableUnits, yVariable, yVariableUnits)
% READ_OPTICAL_PROPERTIES 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh
  
  fullFilename = [LAMPsolar_data_path, '/optical_constants/', filename, '.txt'];
  data = load(fullFilename); 
  disp(['Loading ', fullFilename]);

  if strcmpi(xVariable, 'energy')
    if strcmpi(xVariableUnits, 'eV')
      obj.Wavelength = Photon.ConvertEnergyToWavelength(data(:, 1));
    else
      disp('currently not supported');
    end
  elseif strcmpi(xVariable, 'wavelength')
    if strcmpi(xVariableUnits, 'nm')
      obj.Wavelength = data(:, 1);
    else
      disp('currently not supported');
    end
  end
  
  if strcmpi(yVariable, 'alpha')
    if strcmpi(yVariableUnits, '1/nm')
      frequency = Photon.ConvertWavelengthToFrequency(obj.Wavelength);
      obj.K = OpticalProperties.ConvertAlphaToK(data(:, 2), frequency);
      obj.N = zeros(length(data(:, 2)), 1);
    elseif strcmpi(yVariableUnits, '1/cm')
      alpha = data(:, 2)*Constants.UnitConversions.CMperNM;
      frequency = Photon.ConvertWavelengthToFrequency(obj.Wavelength);
      obj.K = OpticalProperties.ConvertAlphaToK(alpha, frequency);
      obj.N = zeros(length(data(:, 2)), 1);
    else
      disp('currently not supported');
    end
    
  end
end