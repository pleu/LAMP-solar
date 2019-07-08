function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  
  write_lsf_set_property_line(fid, 'first axis', obj.FirstAxis);
  if ~strcmp(obj.FirstAxis,'none') 
      write_lsf_set_property_line(fid, 'rotation 1', obj.Rotation1);
  end
  
  write_lsf_set_property_line(fid, 'second axis', obj.SecondAxis);
  if ~strcmp(obj.SecondAxis,'none') 
      write_lsf_set_property_line(fid, 'rotation 2', obj.Rotation2);
  end
  
  write_lsf_set_property_line(fid, 'third axis', obj.ThirdAxis);
  if ~strcmp(obj.ThirdAxis,'none') 
      write_lsf_set_property_line(fid, 'rotation 3', obj.Rotation3);  
  end
  
  fclose(fid);
  
end
