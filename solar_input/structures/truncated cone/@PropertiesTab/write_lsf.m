function [] = write_lsf(obj, filename)
%
%
  fid = fopen(create_lsf_filename(filename), 'a+');
  write_lsf_set_property_line(fid, 'x', obj.x);
  write_lsf_set_property_line(fid, 'y', obj.y);
  write_lsf_set_property_line(fid, 'z', obj.z);
  write_lsf_set_property_line(fid, 'material', obj.MaterialValue);
  write_lsf_set_property_line(fid, 'r top', obj.rTopValue);
  write_lsf_set_property_line(fid, 'r bottom', obj.rBottomValue);
  write_lsf_set_property_line(fid, 'z span', obj.zSpanValue);

  fclose(fid);
  
end
