function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, 'addplane; \n');
  fclose(fid);
  
  obj.General.write_lsf(filename);
  obj.Geometry.write_lsf(filename);
  obj.FrequencyWavelength.write_lsf(filename);
  obj.BeamOptions.write_lsf(filename);
   
end

