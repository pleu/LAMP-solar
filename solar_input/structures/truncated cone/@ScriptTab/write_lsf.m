function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  
%  write_lsf_set_property_line(fid, 'construction group', obj.ConstructionGroup);
  write_lsf_set_property_line(fid, 'Script', obj.Script);

  fclose(fid);
  
end
