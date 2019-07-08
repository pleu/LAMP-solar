function p = LAMPsolar_data_path()

LAMPsolar_data_path = get_LAMPsolar_option('LAMPsolar_data_path');

if exist(LAMPsolar_data_path,'dir')
  p = LAMPsolar_data_path;
else
  error('Data package not installed!');
end
