function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  
  fprintf(fid, ['rTopValue = ', num2str(obj.RTopValue), '; \n']);  
  fprintf(fid, ['rBottomValue = ', num2str(obj.RBottomValue), '; \n']);
  fprintf(fid, ['zSpanValue = ', num2str(obj.ZSpanValue), '; \n']);
  fprintf(fid, 'adduserprop("material",5,"etch"); \n');
  fprintf(fid, 'adduserprop("r top",2,rTopValue); \n');
  fprintf(fid, 'adduserprop("r bottom",2,rBottomValue); \n');
  fprintf(fid, 'adduserprop("z span",2,zSpanValue); \n');


  write_lsf_set_property_line(fid, 'x', obj.X);
  write_lsf_set_property_line(fid, 'y', obj.Y);
  write_lsf_set_property_line(fid, 'z', obj.Z);
  write_lsf_set_property_line(fid, 'material', obj.MaterialValue);
%   write_lsf_set_property_line(fid, 'r top', obj.rTopValue);
%   write_lsf_set_property_line(fid, 'r bottom', obj.rBottomValue);
%   write_lsf_set_property_line(fid, 'z span', obj.zSpanValue);

  fclose(fid);
  
end
