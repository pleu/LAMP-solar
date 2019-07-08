function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  obj.Cone.write_lsf(filename);
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  %fprintf(fid, ['filename = ','"rtop' num2str(obj.RTop*1e9), 'rbot" +num2str(', num2str(obj.RBot*1e9), ')' '; \n']);  
  %write_lsf_set_property_line(fid, 'z span', obj.ConeH);

  fclose(fid); 
end
