function [] = write_lsf(obj, filename)
%WRITELSFFILE Summary of this function goes here
%   Detailed explanation goes here
  
  fid = fopen(create_lsf_filename(filename), 'a+');
  
%   fprintf(fid, ['rTopValue = ', num2str(obj.RTopValue), '; \n']);  
%   fprintf(fid, ['rBottomValue = ', num2str(obj.RBottomValue), '; \n']);  
%   fprintf(fid, ['zSpanValue = ', num2str(obj.ZSpanValue), '; \n']);  
  
  fprintf(fid, 'addstructuregroup; \n');  
  fprintf(fid, 'set("name","woodpile"); \n');
  %fprintf(fid, 'addobject('trunc_cone'); \n');
  fclose(fid);
  
  obj.Properties.write_lsf(filename);
  obj.Script.write_lsf(filename);
  obj.Rotations.write_lsf(filename);
   
end