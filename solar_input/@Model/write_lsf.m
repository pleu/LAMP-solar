function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  %fid = fopen(create_lsf_filename(filename), 'a+');
  fid = fopen(create_lsf_filename(filename), 'a+');
  fprintf(fid, 'newproject; \n');
  fclose(fid);
  
  obj.Structures.write_lsf(filename);
  obj.Source.write_lsf(filename);
  obj.Monitor1.write_lsf(filename);
  obj.Monitor2.write_lsf(filename); 
  obj.SimulationCell.write_lsf(filename);
  obj.write_ouptut(filename);

end
