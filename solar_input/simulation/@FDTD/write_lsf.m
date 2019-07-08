function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, 'addfdtd; \n');
  fclose(fid);
  
  obj.General.write_lsf(filename);
  obj.Geometry.write_lsf(filename);
  obj.MeshSettings.write_lsf(filename);
  obj.BoundaryConditions.write_lsf(filename);
  obj.AdvancedOptions.write_lsf(filename);
   
end
