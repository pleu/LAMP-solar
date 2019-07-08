function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  obj.Film.write_lsf(filename);
  obj.Cone.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'z span', obj.ConeH);

  fclose(fid); 
end