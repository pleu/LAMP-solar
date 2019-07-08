function [wavelength, n, k] = read_optical_constants(material)
% READ_OPTICAL_CONSTANTS_FILE 
% Reads the optical constants file

  ANGSTROMS_TO_NM = 0.1;
  filename = [LAMPsolar_data_path, '/optical_constants/', material, '.txt'];
  if exist(filename, 'file');
    data = load(filename); 
    disp(['Loading ', filename]);
  else
    filename = [material, '.txt'];
    data = load(filename);
    disp(['Loading ', filename]);
  end
  wavelength = data(:, 1)*ANGSTROMS_TO_NM;  % in nm
  n = data(:, 2);           % this uses convention n - ik
  if size(data, 2) == 3
    k = data(:, 3);
  else
    k = zeros(size(data, 1), 1);
  end
end


