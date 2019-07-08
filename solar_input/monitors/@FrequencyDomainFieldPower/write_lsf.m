function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  
  fprintf(fid, 'addpower; \n');
  fclose(fid);
  
  obj.General.write_lsf(filename);
  obj.Advanced.write_lsf(filename);
  obj.DataToRecord.write_lsf(filename);
  obj.Geometry.write_lsf(filename);
  obj.Spectral.write_lsf(filename); 
  
end
