function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, 'addrect; \n');
  fclose(fid);
  
  obj.Geometry.write_lsf(filename);
  obj.Material.write_lsf(filename);
  obj.Rotations.write_lsf(filename);
  obj.GraphicalRendering.write_lsf(filename);
   
end