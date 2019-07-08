function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'w+t');
  fprintf(fid, 'addobject("trunc_cone"); \n');  
  %fprintf(fid, 'addobject('trunc_cone'); \n');
  fclose(fid);
  
  obj.Properties.write_lsf(filename);
  obj.Script.write_lsf(filename);
  obj.Rotations.write_lsf(filename);
   
end